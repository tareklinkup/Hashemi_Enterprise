<?php
    class Graph extends CI_Controller{
        public function __construct(){
            parent::__construct();
            $access = $this->session->userdata('userId');
            $this->branchId = $this->session->userdata('BRANCHid');
            if($access == '' ){
                redirect("Login");
            }
            $this->load->model('Model_table', "mt", TRUE);
        }
        
        public function graph(){
            $data['title'] = "Graph";
            $data['content'] = $this->load->view('Administrator/graph/graph', $data, true);
            $this->load->view('Administrator/index', $data);
        }

        public function getGraphData(){
            // Monthly Record
            $monthlyRecord = [];
            $year = date('Y');
            $month = date('m');
            $dayNumber = cal_days_in_month(CAL_GREGORIAN, $month, $year);
            for($i = 1; $i <= $dayNumber; $i++){
                $date = $year . '-' . $month . '-'. sprintf("%02d", $i);
                $query = $this->db->query("
                    select ifnull(sum(sm.SaleMaster_TotalSaleAmount), 0) as sales_amount 
                    from tbl_salesmaster sm 
                    where sm.SaleMaster_SaleDate = ?
                    and sm.Status = 'a'
                    and sm.SaleMaster_branchid = ?
                    group by sm.SaleMaster_SaleDate
                ", [$date, $this->branchId]);

                $amount = 0.00;

                if($query->num_rows() == 0){
                    $amount = 0.00;
                } else {
                    $amount = $query->row()->sales_amount;
                }
                $sale = [sprintf("%02d", $i), $amount];
                array_push($monthlyRecord, $sale);
            }

            // Sales text for marquee
            $sales = $this->db->query("
                select 
                    concat(
                        'Invoice: ', sm.SaleMaster_InvoiceNo,
                        ', Customer: ', c.Customer_Code, ' - ', c.Customer_Name,
                        ', Amount: ', sm.SaleMaster_TotalSaleAmount,
                        ', Paid: ', sm.SaleMaster_PaidAmount,
                        ', Due: ', sm.SaleMaster_DueAmount
                    ) as sale_text
                from tbl_salesmaster sm 
                join tbl_customer c on c.Customer_SlNo = sm.SalseCustomer_IDNo
                where sm.Status = 'a'
                and sm.SaleMaster_branchid = ?
                order by sm.SaleMaster_SlNo desc limit 20
            ", $this->branchId)->result();

            // Today's Sale
            $todaysSale = $this->db->query("
                select 
                    ifnull(sum(ifnull(sm.SaleMaster_TotalSaleAmount, 0)), 0) as total_amount
                from tbl_salesmaster sm
                where sm.Status = 'a'
                and sm.SaleMaster_SaleDate = ?
                and sm.SaleMaster_branchid = ?
            ", [date('Y-m-d'), $this->branchId])->row()->total_amount;

            // This Month's Sale
            $thisMonthSale = $this->db->query("
                select 
                    ifnull(sum(ifnull(sm.SaleMaster_TotalSaleAmount, 0)), 0) as total_amount
                from tbl_salesmaster sm
                where sm.Status = 'a'
                and month(sm.SaleMaster_SaleDate) = ?
                and sm.SaleMaster_branchid = ?
            ", [date('m'), $this->branchId])->row()->total_amount;

            // Today's Cash Collection
            $todaysCollection = $this->db->query("
                select 
                ifnull((
                    select sum(ifnull(sm.SaleMaster_PaidAmount, 0)) 
                    from tbl_salesmaster sm
                    where sm.Status = 'a'
                    and sm.SaleMaster_branchid = " . $this->branchId . "
                    and sm.SaleMaster_SaleDate = '" . date('Y-m-d') . "'
                ), 0) +
                ifnull((
                    select sum(ifnull(cp.CPayment_amount, 0)) 
                    from tbl_customer_payment cp
                    where cp.CPayment_status = 'a'
                    and cp.CPayment_brunchid = " . $this->branchId . "
                    and cp.CPayment_date = '" . date('Y-m-d') . "'
                ), 0) +
                ifnull((
                    select sum(ifnull(ct.In_Amount, 0)) 
                    from tbl_cashtransaction ct
                    where ct.status = 'a'
                    and ct.Tr_branchid = " . $this->branchId . "
                    and ct.Tr_date = '" . date('Y-m-d') . "'
                ), 0) as total_amount
            ")->row()->total_amount;

            // Cash Balance
            $cashBalance = $this->mt->getTransactionSummary()->cash_balance;

            // Top Customers
            $topCustomers = $this->db->query("
                select 
                c.Customer_Name as customer_name,
                ifnull(sum(sm.SaleMaster_TotalSaleAmount), 0) as amount
                from tbl_salesmaster sm 
                join tbl_customer c on c.Customer_SlNo = sm.SalseCustomer_IDNo
                where sm.SaleMaster_branchid = ?
                group by sm.SalseCustomer_IDNo
                order by amount desc 
                limit 5
            ", $this->branchId)->result();

            // Top Products
            $topProducts = $this->db->query("
                select 
                    p.Product_Name as product_name,
                    ifnull(sum(sd.SaleDetails_TotalQuantity), 0) as sold_quantity
                from tbl_saledetails sd
                join tbl_product p on p.Product_SlNo = sd.Product_IDNo
                group by sd.Product_IDNo
                order by sold_quantity desc
                limit 5
            ")->result();

            $responseData = [
                'monthly_record' => $monthlyRecord,
                'sales_text' => $sales,
                'todays_sale' => $todaysSale,
                'this_month_sale' => $thisMonthSale,
                'todays_collection' => $todaysCollection,
                'cash_balance' => $cashBalance,
                'top_customers' => $topCustomers,
                'top_products' => $topProducts
            ];

            echo json_encode($responseData, JSON_NUMERIC_CHECK);
        }
    }
?>