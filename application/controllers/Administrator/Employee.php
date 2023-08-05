<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Employee extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->brunch = $this->session->userdata('BRANCHid');
        $access = $this->session->userdata('userId');
        if ($access == '') {
            redirect("Login");
        }
        $this->load->model('Billing_model');
        $this->load->model("Model_myclass", "mmc", TRUE);
        $this->load->model('Model_table', "mt", TRUE);

        $vars['branch_info'] = $this->Billing_model->company_branch_profile($this->brunch);
        $this->load->vars($vars);
    }

    public function index()
    {
        $access = $this->mt->userAccess();
        if (!$access) {
            redirect(base_url());
        }
        $data['title'] = "Employee";
        $data['content'] = $this->load->view('Administrator/employee/add_employee', $data, TRUE);
        $this->load->view('Administrator/index', $data);
    }

    public function getEmployees()
    {
        $employees = $this->db->query("
            select 
                e.*,
                dp.Department_Name,
                ds.Designation_Name,
                concat(e.Employee_Name, ' - ', e.Employee_ID) as display_name
            from tbl_employee e 
            join tbl_department dp on dp.Department_SlNo = e.Department_ID
            join tbl_designation ds on ds.Designation_SlNo = e.Designation_ID
            where e.status = 'a'
            and e.Employee_brinchid = ?
        ", $this->session->userdata('BRANCHid'))->result();

        echo json_encode($employees);
    }

    public function getMonths()
    {
        $months = $this->db->query("
            select * from tbl_month
        ")->result();

        echo json_encode($months);
    }

    public function getEmployeePayments()
    {
        $data = json_decode($this->input->raw_input_stream);

        $clauses = "";
        if (isset($data->employeeId) && $data->employeeId != '') {
            $clauses .= " and e.Employee_SlNo = '$data->employeeId'";
        }

        if (isset($data->month) && $data->month != '') {
            $clauses .= " and ep.month_id = '$data->month'";
        }

        if (isset($data->dateFrom) && $data->dateFrom != '' && isset($data->dateTo) && $data->dateTo != '') {
            $clauses .= " and ep.payment_date between '$data->dateFrom' and '$data->dateTo'";
        }

        $payments = $this->db->query("
            select 
                ep.*,
                e.Employee_Name,
                e.Employee_ID,
                e.salary_range,
                dp.Department_Name,
                ds.Designation_Name,
                m.month_name
            from tbl_employee_payment ep
            join tbl_employee e on e.Employee_SlNo = ep.Employee_SlNo
            join tbl_department dp on dp.Department_SlNo = e.Department_ID
            join tbl_designation ds on ds.Designation_SlNo = e.Designation_ID
            join tbl_month m on m.month_id = ep.month_id
            where ep.paymentBranch_id = ?
            and ep.status = 'a'
            $clauses
            order by ep.employee_payment_id desc
        ", $this->session->userdata('BRANCHid'))->result();

        echo json_encode($payments);
    }

    public function getSalarySummary()
    {

        $data = json_decode($this->input->raw_input_stream);

        $yearMonth = date("Ym", strtotime($data->monthName));

        $summary = $this->db->query("
            select 
                e.*,
                dp.Department_Name,
                ds.Designation_Name,
                (
                    select ifnull(sum(ep.payment_amount), 0) from tbl_employee_payment ep
                    where ep.Employee_SlNo = e.Employee_SlNo
                    and ep.status = 'a'
                    and ep.month_id = " . $data->monthId . "
                    and ep.paymentBranch_id = " . $this->session->userdata('BRANCHid') . "
                ) as paid_amount,
                
                (
                    select ifnull(sum(ep.deduction_amount), 0) from tbl_employee_payment ep
                    where ep.Employee_SlNo = e.Employee_SlNo
                    and ep.status = 'a'
                    and ep.month_id = " . $data->monthId . "
                    and ep.paymentBranch_id = " . $this->session->userdata('BRANCHid') . "
                ) as deducted_amount,
                
                (
                    select e.salary_range - (paid_amount + deducted_amount)
                ) as due_amount
                
            from tbl_employee e 
            join tbl_department dp on dp.Department_SlNo = e.Designation_ID
            join tbl_designation ds on ds.Designation_SlNo = e.Designation_ID
            where e.status = 'a'
            and " . $yearMonth . " >= extract(YEAR_MONTH from e.Employee_JoinDate)
            and e.Employee_brinchid = " . $this->session->userdata('BRANCHid') . "
        ")->result();

        echo json_encode($summary);
    }

    public function getPayableSalary()
    {
        $data = json_decode($this->input->raw_input_stream);

        // $payableAmount = $this->db->query("
        //     select 
        //     (e.salary_range - ifnull(sum(ep.payment_amount + ep.deduction_amount), 0)) as payable_amount
        //     from tbl_employee_payment ep
        //     join tbl_employee e on e.Employee_SlNo = ep.Employee_SlNo
        //     where ep.status = 'a'
        //     and ep.month_id = ?
        //     and ep.Employee_SlNo = ?
        //     and ep.paymentBranch_id = ?        
        // ", [$data->monthId, $data->employeeId, $this->brunch])->row()->payable_amount;

        // $payableAmount = $this->db->query("
        // select e.Employee_Name, e.salary_range as salary,

        // (select ifnull(sum(ep.payment_amount),0)
        // FROM tbl_employee_payment ep
        // WHERE ep.status = 'a'
        // and ep.month_id = '$data->monthId'
        // and ep.Employee_SlNo = '$data->employeeId'
        // and ep.paymentBranch_id = '$this->brunch' ) as payment_amount,

        // (select ifnull(sum(ep.deduction_amount),0)
        // FROM tbl_employee_payment ep
        // WHERE ep.status = 'a'
        // and ep.month_id = '$data->monthId'
        // and ep.Employee_SlNo = '$data->employeeId'
        // and ep.paymentBranch_id = '$this->brunch' ) as deduct_amount,

        // (select ifnull(sum(el.amount),0)
        // FROM tbl_employee_leave el
        // WHERE el.status = 'a'
        // and el.month_id = '$data->monthId'
        // and el.employee_id = '$data->employeeId'
        // and el.branch_id = '$this->brunch' ) as leave_deduct_amount

        // from tbl_employee e
        // where e.status = 'a'
        // and e.Employee_SlNo = ?
        // and e.Employee_brinchid = ?  
        // ", [$data->employeeId, $this->brunch])->row();

        // $payable_amount = $payableAmount->salary - ($payableAmount->payment_amount + $payableAmount->deduct_amount + $payableAmount->leave_deduct_amount);

        $payableAmount = $this->db->query("
        select e.Employee_Name, e.salary_range as salary,

        (select ifnull(sum(ep.payment_amount),0)
        FROM tbl_employee_payment ep
        WHERE ep.status = 'a'
        and ep.month_id = '$data->monthId'
        and ep.Employee_SlNo = '$data->employeeId'
        and ep.paymentBranch_id = '$this->brunch' ) as payment_amount,

        (select ifnull(sum(ep.deduction_amount),0)
        FROM tbl_employee_payment ep
        WHERE ep.status = 'a'
        and ep.month_id = '$data->monthId'
        and ep.Employee_SlNo = '$data->employeeId'
        and ep.paymentBranch_id = '$this->brunch' ) as deduct_amount

        from tbl_employee e
        where e.status = 'a'
        and e.Employee_SlNo = ?
        and e.Employee_brinchid = ?  
        ", [$data->employeeId, $this->brunch])->row();

        $payable_amount = $payableAmount->salary - ($payableAmount->payment_amount + $payableAmount->deduct_amount);

        echo $payable_amount;
    }

    //Designation
    public function designation()
    {
        $access = $this->mt->userAccess();
        if (!$access) {
            redirect(base_url());
        }
        $data['title'] = "Add Designation";
        $data['content'] = $this->load->view('Administrator/employee/designation', $data, TRUE);
        $this->load->view('Administrator/index', $data);
    }

    public function insert_designation()
    {
        $mail = $this->input->post('Designation');
        $query = $this->db->query("SELECT Designation_Name from tbl_designation where Designation_Name = '$mail'");

        if ($query->num_rows() > 0) {
            $data['exists'] = "This Name is Already Exists";
            $this->load->view('Administrator/ajax/designation', $data);
        } else {
            $data = array(
                "Designation_Name" => $this->input->post('Designation', TRUE),
                "AddBy" => $this->session->userdata("FullName"),
                "AddTime" => date("Y-m-d H:i:s")
            );
            $this->mt->save_data('tbl_designation', $data);
            //$this->load->view('Administrator/ajax/designation');
        }
    }

    public function designationedit($id)
    {
        $data['title'] = "Edit Designation";
        $fld = 'Designation_SlNo';
        $data['selected'] = $this->Billing_model->select_by_id('tbl_designation', $id, $fld);
        $this->load->view('Administrator/edit/designation_edit', $data);
    }

    public function designationupdate()
    {
        $id = $this->input->post('id');
        $fld = 'Designation_SlNo';
        $data = array(
            "Designation_Name" => $this->input->post('Designation', TRUE),
            "UpdateBy" => $this->session->userdata("FullName"),
            "UpdateTime" => date("Y-m-d H:i:s")
        );
        $this->mt->update_data("tbl_designation", $data, $id, $fld);
    }

    public function designationdelete()
    {
        $fld = 'Designation_SlNo';
        $id = $this->input->post('deleted');
        $this->mt->delete_data("tbl_designation", $id, $fld);
        //$this->load->view('Administrator/ajax/designation');

    }
    //^^^^^^^^^^^^^^^^^^^^^^^^^
    //
    public function depertment()
    {
        $access = $this->mt->userAccess();
        if (!$access) {
            redirect(base_url());
        }
        $data['title'] = "Add Depertment";
        $data['content'] = $this->load->view('Administrator/employee/depertment', $data, TRUE);
        $this->load->view('Administrator/index', $data);
    }

    public function insert_depertment()
    {
        $mail = $this->input->post('Depertment');
        $query = $this->db->query("SELECT Department_Name from tbl_department where Department_Name = '$mail'");

        if ($query->num_rows() > 0) {
            $exists = "This Name is Already Exists";
            echo json_encode($exists);
            //$this->load->view('Administrator/ajax/depertment', $data);
        } else {
            $data = array(
                "Department_Name" => $this->input->post('Depertment', TRUE),
                "AddBy" => $this->session->userdata("FullName"),
                "AddTime" => date("Y-m-d H:i:s")
            );
            $this->mt->save_data('tbl_department', $data);
            $message = "Save Successful";
            echo json_encode($message);
        }
    }

    public function depertmentedit($id)
    {
        $data['title'] = "Edit Department";
        $fld = 'Department_SlNo';
        $data['selected'] = $this->Billing_model->select_by_id('tbl_department', $id, $fld);
        $data['content'] = $this->load->view('Administrator/edit/depertment_edit', $data);
        //$this->load->view('Administrator/index', $data);
    }

    public function depertmentupdate()
    {
        $id = $this->input->post('id');
        $fld = 'Department_SlNo';
        $data = array(
            "Department_Name" => $this->input->post('Depertment', TRUE),
            "UpdateBy" => $this->session->userdata("FullName"),
            "UpdateTime" => date("Y-m-d H:i:s")
        );
        $this->mt->update_data("tbl_department", $data, $id, $fld);
    }

    public function depertmentdelete()
    {
        $fld = 'Department_SlNo';
        $id = $this->input->post('deleted');
        $this->mt->delete_data("tbl_department", $id, $fld);
        //$this->load->view('Administrator/ajax/depertment');

    }

    //^^^^^^^^^^^^^^^^^^^^
    public function emplists()
    {
        $access = $this->mt->userAccess();
        if (!$access) {
            redirect(base_url());
        }
        $data['title'] = "Employee List";
        $data['employes'] = $this->HR_model->get_all_employee_list();
        $data['content'] = $this->load->view('Administrator/employee/list', $data, TRUE);
        $this->load->view('Administrator/index', $data);
    }

    // fancybox add
    public function fancybox_depertment()
    {
        $this->load->view('Administrator/employee/em_depertment');
    }

    public function fancybox_insert_depertment()
    {
        $mail = $this->input->post('Depertment');
        $query = $this->db->query("SELECT Department_Name from tbl_department where Department_Name = '$mail'");

        if ($query->num_rows() > 0) {
            $data['exists'] = "This Name is Already Exists";
            $this->load->view('Administrator/ajax/fancybox_depertmetn', $data);
        } else {
            $data = array(
                "Department_Name" => $this->input->post('Depertment', TRUE),
                "AddBy" => $this->session->userdata("FullName"),
                "AddTime" => date("Y-m-d H:i:s")
            );
            $this->mt->save_data('tbl_department', $data);
            $this->load->view('Administrator/ajax/fancybox_depertmetn');
        }
    }
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    // fancybox add 
    public function month()
    {
        $access = $this->mt->userAccess();
        if (!$access) {
            redirect(base_url());
        }
        $data['title'] = 'Month';
        $data['content'] = $this->load->view('Administrator/employee/month', $data, TRUE);
        $this->load->view('Administrator/index', $data);
    }

    public function insert_month()
    {
        $month_name = $this->input->post('month');
        $query = $this->db->query("SELECT month_name from tbl_month where month_name = '$month_name'");

        if ($query->num_rows() > 0) {
            $exists = "This Name is Already Exists";
            echo json_encode($exists);
        } else {
            $data = array(
                "month_name" => $this->input->post('month', TRUE),
                /*   "AddBy"                  =>$this->session->userdata("FullName"),
                  "AddTime"                =>date("Y-m-d H:i:s") */
            );
            if ($this->mt->save_data('tbl_month', $data)) {
                $message = "Month insert success";
                echo json_encode($message);
            }
        }
    }

    public function editMonth($id)
    {
        $query = $this->db->query("SELECT * from tbl_month where month_id = '$id'");
        $data['row'] = $query->row();
        $this->load->view('Administrator/employee/edit_month', $data);
    }

    public function updateMonth()
    {
        $id = $this->input->post('month_id');
        $fld = 'month_id';
        $data = array(
            "month_name" => $this->input->post('month', TRUE),
        );
        if ($this->mt->update_data("tbl_month", $data, $id, $fld)) {
            //$message = "Update insert success";
            //echo json_encode($message);
            redirect('month');
        }
    }

    public function fancybox_designation()
    {
        $this->load->view('Administrator/employee/em_designation');
    }

    public function fancybox_insert_designation()
    {
        $mail = $this->input->post('Designation');
        $query = $this->db->query("SELECT Designation_Name from tbl_designation where Designation_Name = '$mail'");

        if ($query->num_rows() > 0) {
            $data['exists'] = "This Name is Already Exists";
            $this->load->view('Administrator/ajax/fancybox_designation', $data);
        } else {
            $data = array(
                "Designation_Name" => $this->input->post('Designation', TRUE),
                "AddBy" => $this->session->userdata("FullName"),
                "AddTime" => date("Y-m-d H:i:s")
            );
            $this->mt->save_data('tbl_designation', $data);
            $this->load->view('Administrator/ajax/fancybox_designation');
        }
    }
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    // Employee Insert
    public function employee_insert()
    {
        $data = array();
        $this->load->library('upload');
        $config['upload_path'] = './uploads/employeePhoto_org/';
        $config['allowed_types'] = 'gif|jpg|png|jpeg';
        $config['max_size'] = '10000';
        $config['image_width'] = '4000';
        $config['image_height'] = '4000';
        $this->upload->initialize($config);

        $data['Designation_ID'] = $this->input->post('em_Designation', true);
        $data['Department_ID'] = $this->input->post('em_Depertment', true);
        $data['Employee_ID'] = $this->input->post('Employeer_id', true);
        $data['Employee_Name'] = $this->input->post('em_name', true);
        $data['Employee_JoinDate'] = $this->input->post('em_Joint_date');
        $data['Employee_Gender'] = $this->input->post('Gender', true);
        $data['Employee_BirthDate'] = $this->input->post('em_dob', true);
        $data['Employee_ContactNo'] = $this->input->post('em_contact', true);
        $data['Employee_Email'] = $this->input->post('ec_email', true);
        $data['Employee_MaritalStatus'] = $this->input->post('Marital', true);
        $data['Employee_FatherName'] = $this->input->post('em_father', true);
        $data['Employee_MotherName'] = $this->input->post('mother_name', true);
        $data['Employee_PrasentAddress'] = $this->input->post('em_Present_address', true);
        $data['Employee_PermanentAddress'] = $this->input->post('em_Permanent_address', true);
        $data['salary_range'] = $this->input->post('salary_range', true);
        $data['status'] = 'a';

        $data['AddBy'] = $this->session->userdata("FullName");
        $data['Employee_brinchid'] = $this->session->userdata("BRANCHid");
        $data['AddTime'] = date("Y-m-d H:i:s");

        $this->upload->do_upload('em_photo');
        $images = $this->upload->data();
        $data['Employee_Pic_org'] = $images['file_name'];

        $config['image_library'] = 'gd2';
        $config['source_image'] = $this->upload->upload_path . $this->upload->file_name;
        $config['new_image'] = 'uploads/' . 'employeePhoto_thum/' . $this->upload->file_name;
        $config['maintain_ratio'] = FALSE;
        $config['width'] = 165;
        $config['height'] = 175;
        $this->load->library('image_lib', $config);
        $this->image_lib->resize();
        $data['Employee_Pic_thum'] = $this->upload->file_name;
        //echo "<pre>";print_r($data);exit;
        $this->mt->save_data('tbl_employee', $data);
        //$this->Billing_model->save_employee_data($data);
        //redirect('Administrator/Employee/');
        //$this->load->view('Administrator/ajax/add_employee');
    }

    public function employee_edit($id)
    {
        $data['title'] = "Edit Employee";
        $query = $this->db->query("SELECT tbl_employee.*,tbl_department.*,tbl_designation.* FROM tbl_employee left join tbl_department on tbl_department.Department_SlNo=tbl_employee.Department_ID left join tbl_designation on tbl_designation.Designation_SlNo=tbl_employee.Designation_ID  where tbl_employee.Employee_SlNo = '$id'");
        $data['selected'] = $query->row();
        //echo "<pre>";print_r($data['selected']);exit;
        $data['content'] = $this->load->view('Administrator/edit/employee_edit', $data, TRUE);
        $this->load->view('Administrator/index', $data);
    }

    public function employee_Update()
    {

        $id = $this->input->post('iidd');
        $fld = 'Employee_SlNo';
        $this->load->library('upload');
        $config['upload_path'] = './uploads/employeePhoto_org/';
        $config['allowed_types'] = 'gif|jpg|png|jpeg';
        $config['max_size'] = '10000';
        $config['image_width'] = '4000';
        $config['image_height'] = '4000';
        $this->upload->initialize($config);

        $data['Designation_ID'] = $this->input->post('em_Designation', true);
        $data['Department_ID'] = $this->input->post('em_Depertment', true);
        $data['Employee_ID'] = $this->input->post('Employeer_id', true);
        $data['Employee_Name'] = $this->input->post('em_name', true);
        $data['Employee_JoinDate'] = $this->input->post('em_Joint_date');
        $data['Employee_Gender'] = $this->input->post('Gender', true);
        $data['Employee_BirthDate'] = $this->input->post('em_dob', true);
        $data['Employee_ContactNo'] = $this->input->post('em_contact', true);
        $data['Employee_Email'] = $this->input->post('ec_email', true);
        $data['Employee_MaritalStatus'] = $this->input->post('Marital', true);
        $data['Employee_FatherName'] = $this->input->post('em_father', true);
        $data['Employee_MotherName'] = $this->input->post('mother_name', true);
        $data['Employee_PrasentAddress'] = $this->input->post('em_Present_address', true);
        $data['Employee_PermanentAddress'] = $this->input->post('em_Permanent_address', true);
        $data['Employee_brinchid'] = $this->session->userdata("BRANCHid");
        $data['salary_range'] = $this->input->post('salary_range', true);

        $data['UpdateBy'] = $this->session->userdata("FullName");
        $data['UpdateTime'] = date("Y-m-d H:i:s");

        $xx = $this->mt->select_by_id("tbl_employee", $id, $fld);

        $image = $this->upload->do_upload('em_photo');
        $images = $this->upload->data();

        if ($image != "") {
            if ($xx['Employee_Pic_thum'] && $xx['Employee_Pic_org']) {
                unlink("./uploads/employeePhoto_thum/" . $xx['Employee_Pic_thum']);
                unlink("./uploads/employeePhoto_org/" . $xx['Employee_Pic_org']);
            }
            $data['Employee_Pic_org'] = $images['file_name'];

            $config['image_library'] = 'gd2';
            $config['source_image'] = $this->upload->upload_path . $this->upload->file_name;
            $config['new_image'] = 'uploads/' . 'employeePhoto_thum/' . $this->upload->file_name;
            $config['maintain_ratio'] = FALSE;
            $config['width'] = 165;
            $config['height'] = 175;
            $this->load->library('image_lib', $config);
            $this->image_lib->resize();
            $data['Employee_Pic_thum'] = $this->upload->file_name;
        } else {

            $data['Employee_Pic_org'] = $xx['Employee_Pic_org'];
            $data['Employee_Pic_thum'] = $xx['Employee_Pic_thum'];
        }

        $this->mt->update_data("tbl_employee", $data, $id, $fld);
    }

    public function employee_Delete()
    {
        $id = $this->input->post('deleted');
        $this->db->set(['status' => 'd'])->where('Employee_SlNo', $id)->update('tbl_employee');
    }

    public function active()
    {
        $fld = 'Employee_SlNo';
        $id = $this->input->post('deleted');
        $this->mt->active("tbl_employee", $id, $fld);
        // $this->load->view('Administrator/ajax/employee_list');
    }

    public function employeesalarypayment()
    {
        $access = $this->mt->userAccess();
        if (!$access) {
            redirect(base_url());
        }
        $data['title'] = "Employee Salary Payment";
        $data['content'] = $this->load->view('Administrator/employee/employee_salary', $data, TRUE);
        $this->load->view('Administrator/index', $data);
    }

    public function selectEmployee()
    {
        $data['title'] = "Employee Salary Payment";
        $employee_id = $this->input->post('employee_id');
        $query = $this->db->query("SELECT `salary_range` FROM tbl_employee where Employee_SlNo='$employee_id'");
        $data['employee'] = $query->row();
        $this->load->view('Administrator/employee/ajax_employeey', $data);
    }

    public function addEmployeePayment()
    {
        $res = ['success' => false, 'message' => 'Nothing happened'];
        try {
            $paymentObj = json_decode($this->input->raw_input_stream);
            $payment = (array)$paymentObj;

            $checkPayment = $this->db->query("
                select
                    employee_payment_id
                from tbl_employee_payment
                where Employee_SlNo = ? and month_id = ? and paymentBranch_id = ?
                and status ='a'
                ", [$payment['Employee_SlNo'], $payment['month_id'], $this->brunch])->num_rows();

            if ($checkPayment > 0) {
                $firstPayment = $this->db->where('status', 'a')->where('Employee_SlNo', $payment['Employee_SlNo'])->where('month_id', $payment['month_id'])
                    ->get('tbl_employee_payment')->row();
                if ($firstPayment->salary_range == 0) {
                    $this->db->where('status', 'a')
                        ->where('employee_payment_id', $firstPayment->employee_payment_id)
                        ->update('tbl_employee_payment', ['salary_range' => $payment['salary_range']]);
                }
                unset($payment['salary_range']);
            }

            unset($payment['employee_payment_id']);
            $payment['status'] = 'a';
            $payment['save_by'] = $this->session->userdata('userId');
            $payment['save_date'] = Date('Y-m-d H:i:s');
            $payment['paymentBranch_id'] = $this->brunch;

            $this->db->insert('tbl_employee_payment', $payment);
            $res = ['success' => true, 'message' => 'Employee payment added'];
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }

        echo json_encode($res);
    }

    public function employeesalaryreport()
    {
        $access = $this->mt->userAccess();
        if (!$access) {
            redirect(base_url());
        }
        $data['title'] = "Employee Salary Report";
        $data['content'] = $this->load->view('Administrator/employee/employee_salary_report', $data, TRUE);
        $this->load->view('Administrator/index', $data);
    }

    public function EmployeeSalary_list()
    {
        $datas['employee_id'] = $employee_id = $this->input->post('employee_id');
        $datas['month'] = $month = $this->input->post('month');

        $this->session->set_userdata($datas);

        $BRANCHid = $this->session->userdata("BRANCHid");

        if ($employee_id == 'All') {

            $employeequery = $this->db
                ->join('tbl_designation', 'tbl_designation.Designation_SlNo=tbl_employee.Designation_ID', 'left')
                ->where('tbl_employee.Employee_brinchid', $BRANCHid)
                ->get('tbl_employee')->result();
            $data['employee_list'] = $employeequery;
        } else {


            $employeequery = $this->db
                ->join('tbl_designation', 'tbl_designation.Designation_SlNo=tbl_employee.Designation_ID', 'left')
                ->where('tbl_employee.Employee_brinchid', $BRANCHid)
                ->where('tbl_employee.Employee_SlNo	', $employee_id)
                ->get('tbl_employee')->result();
            $data['employee_list'] = $employeequery;
        }

        $data['month'] = $month;
        $this->load->view('Administrator/employee/employee_salary_report_list', $data);
    }

    public function EmploeePaymentReportPrint()
    {
        $BRANCHid = $this->session->userdata("BRANCHid");

        $employee_id = $this->session->userdata('employee_id');
        $month = $this->session->userdata('month');

        if ($employee_id == 'All') {

            $employeequery = $this->db
                ->join('tbl_designation', 'tbl_designation.Designation_SlNo=tbl_employee.Designation_ID', 'left')
                ->where('tbl_employee.Employee_brinchid', $BRANCHid)
                ->get('tbl_employee')->result();
            $data['employee_list'] = $employeequery;
        } else {

            $employeequery = $this->db
                ->join('tbl_designation', 'tbl_designation.Designation_SlNo=tbl_employee.Designation_ID', 'left')
                ->where('tbl_employee.Employee_brinchid', $BRANCHid)
                ->where('tbl_employee.Employee_SlNo	', $employee_id)
                ->get('tbl_employee')->result();
            $data['employee_list'] = $employeequery;
        }

        $data['month'] = $month;
        $this->load->view('Administrator/employee/employee_salary_report_print', $data);
    }

    public function edit_employee_salary($id)
    {
        $data['title'] = "Edit Employee Salary";
        $BRANCHid = $this->session->userdata("BRANCHid");
        $query = $this->db->query("SELECT tbl_employee.*,tbl_employee_payment.*,tbl_month.*,tbl_designation.* FROM tbl_employee left join tbl_employee_payment on tbl_employee_payment.Employee_SlNo=tbl_employee.Employee_SlNo left join tbl_month on tbl_employee_payment.month_id=tbl_month.month_id left join tbl_designation on tbl_designation.Designation_SlNo=tbl_employee.Designation_ID where tbl_employee_payment.employee_payment_id='$id' AND tbl_employee_payment.paymentBranch_id='$BRANCHid'");
        $data['selected'] = $query->row();
        //echo "<pre>";print_r($data['selected']);exit;
        $data['content'] = $this->load->view('Administrator/employee/edit_employee_salary', $data, TRUE);
        $this->load->view('Administrator/index', $data);
    }

    public function updateEmployeePayment()
    {
        $res = ['success' => false, 'message' => 'Nothing happened'];
        try {
            $paymentObj = json_decode($this->input->raw_input_stream);
            $payment = (array)$paymentObj;

            $allPayments = $this->db->query("SELECT *
            from tbl_employee_payment
            where Employee_SlNo = ? and month_id = ? and paymentBranch_id = ?
            and status ='a'
            ", [$payment['Employee_SlNo'], $payment['month_id'], $this->brunch])->result();

            $sum = 0;
            foreach ($allPayments as $key => $value) {
                if ($value->employee_payment_id != $payment['employee_payment_id']) {
                    $sum += $value->payment_amount + $value->deduction_amount;
                }
            }

            if ($sum + $payment['payment_amount'] + $payment['deduction_amount'] > $payment['salary_range']) {
                $res = ['success' => false, 'message' => 'Illegal Operation Found!'];
                echo json_encode($res);
                exit;
            }

            $checkPayment = $this->db->query("
                select
                    employee_payment_id
                from tbl_employee_payment
                where Employee_SlNo = ? and month_id = ? and paymentBranch_id = ?
                and status ='a'
                ", [$payment['Employee_SlNo'], $payment['month_id'], $this->brunch])->num_rows();

            if ($checkPayment > 0) {
                $firstPayment = $this->db->where('status', 'a')->where('Employee_SlNo', $payment['Employee_SlNo'])->where('month_id', $payment['month_id'])
                    ->get('tbl_employee_payment')->row();
                if ($firstPayment->salary_range == 0) {
                    $this->db->where('status', 'a')
                        ->where('employee_payment_id', $firstPayment->employee_payment_id)
                        ->update('tbl_employee_payment', ['salary_range' => $payment['salary_range']]);
                }
                unset($payment['salary_range']);
            }

            unset($payment['employee_payment_id']);
            $payment['update_by'] = $this->session->userdata('userId');
            $payment['update_date'] = Date('Y-m-d H:i:s');

            $this->db->where('employee_payment_id', $paymentObj->employee_payment_id)->update('tbl_employee_payment', $payment);
            $res = ['success' => true, 'message' => 'Employee payment updated'];
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }

        echo json_encode($res);
    }

    public function deleteEmployeePayment()
    {
        $res = ['success' => false, 'message' => 'Nothing happened'];
        try {
            $data = json_decode($this->input->raw_input_stream);

            $this->db->set(['status' => 'd'])->where('employee_payment_id', $data->paymentId)->update('tbl_employee_payment');
            $res = ['success' => true, 'message' => 'Employee payment deleted'];
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }

        echo json_encode($res);
    }

    public function getEmployeeLedger()
    {
        $data = json_decode($this->input->raw_input_stream);
        $branchId = $this->session->userdata("BRANCHid");
        $clauses = "";
        if (isset($data->monthId) && $data->monthId != null && $data->monthId != "") {
            $clauses .= " and emp.month_id = $data->monthId";
        }

        if (isset($data->dateFrom) && $data->dateFrom != '' && isset($data->dateTo) && $data->dateTo != '') {
            $clauses .= " AND emp.payment_date BETWEEN '$data->dateFrom' and '$data->dateTo'";
        }

        if (isset($data->employeeId) && $data->employeeId != "" && $data->employeeId != null) {
            $clauses .= " and emp.Employee_SlNo = $data->employeeId";
        }

        $payments = $this->db->query("
            SELECT
                e.Employee_Name,
                e.Employee_ID,
                e.Employee_ContactNo,
                dp.Department_Name,
                emp.Note,
                emp.payment_type,
                ds.Designation_Name,
                m.month_name,
                emp.employee_payment_id,
                emp.Employee_SlNo as employee_id,
                emp.salary_range,
                emp.payment_date,
                emp.month_id,
                emp.payment_amount,
                emp.deduction_amount,
                ifnull((
                    SELECT SUM(emp2.salary_range) - (SUM(emp2.payment_amount) + SUM(emp2.deduction_amount))
                    FROM tbl_employee_payment as emp2
                    WHERE emp2.status ='a'
                    and emp2.month_id = emp.month_id
                    AND emp2.Employee_SlNo = emp.Employee_SlNo
                    AND emp2.employee_payment_id <= emp.employee_payment_id
                ),0) as balance
            
            FROM tbl_employee_payment as emp
            join tbl_employee as e on e.Employee_SlNo = emp.Employee_SlNo
            join tbl_department dp on dp.Department_SlNo = e.Department_ID
            join tbl_designation ds on ds.Designation_SlNo = e.Designation_ID
            join tbl_month m on m.month_id = emp.month_id
            WHERE emp.status ='a'
            AND emp.paymentBranch_id= $branchId
            $clauses
            ORDER BY month_id,payment_date
        ")->result();
        echo json_encode($payments);
    }

    public function employee_loan()
    {
        $access = $this->mt->userAccess();
        if (!$access) {
            redirect(base_url());
        }
        $data['title'] = "Employee Loan Payment";
        $data['content'] = $this->load->view('Administrator/employee/employee_loan', $data, TRUE);
        $this->load->view('Administrator/index', $data);
    }

    public function add_employee_loan()
    {
        $res = ['success' => false, 'message' => 'Nothing happened'];
        try {
            $paymentObj = json_decode($this->input->raw_input_stream);
            $payment = (array)$paymentObj;

            unset($payment['id']);
            $payment['status'] = 'a';
            $payment['save_by'] = $this->session->userdata('userId');
            $payment['save_date'] = Date('Y-m-d H:i:s');
            $payment['branch_id'] = $this->brunch;

            $this->db->insert('tbl_employee_loan', $payment);
            $res = ['success' => true, 'message' => 'Employee Loan payment added'];
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }

        echo json_encode($res);
    }

    public function updateEmployeeLoan()
    {
        $res = ['success' => false, 'message' => 'Nothing happened'];
        try {
            $paymentObj = json_decode($this->input->raw_input_stream);
            $payment = (array)$paymentObj;

            unset($payment['id']);
            $payment['status'] = 'a';
            $payment['save_by'] = $this->session->userdata('userId');
            $payment['save_date'] = Date('Y-m-d H:i:s');
            $payment['branch_id'] = $this->brunch;

            // $this->db->update('tbl_employee_loan', $payment);
            $this->db->where('id', $paymentObj->id)->update('tbl_employee_loan', $payment);
            $res = ['success' => true, 'message' => 'Employee Loan payment update successfully'];
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }

        echo json_encode($res);
    }
    public function deleteEmployeeLoanPayment()
    {
        $paymentObj = json_decode($this->input->raw_input_stream);
        $data = [
            'status' => 'd',
            'update_by' => $this->session->userdata('userId'),
            'update_date' => date('Y-m-d'),
        ];
        $result = $this->db->where('id', $paymentObj->id)->update('tbl_employee_loan', $data);
        if ($result) {
            $res = ['success' => true, 'message' => 'Loan payment delete successfully'];
        } else {
            $res = ['success' => true, 'message' => 'Something going wrong! Please try later'];
        }

        echo json_encode($res);
    }

    public function getEmployeeLoan()
    {
        $data = json_decode($this->input->raw_input_stream);

        $clauses = "";
        if (isset($data->employeeId) && $data->employeeId != '') {
            $clauses .= " and e.Employee_SlNo = '$data->employeeId'";
        }

        // if (isset($data->month) && $data->month != '') {
        //     $clauses .= " and ep.month_id = '$data->month'";
        // }

        if (isset($data->dateFrom) && $data->dateFrom != '' && isset($data->dateTo) && $data->dateTo != '') {
            $clauses .= " and el.payment_date between '$data->dateFrom' and '$data->dateTo'";
        }

        $payments = $this->db->query("
            select 
            el.*,
                e.Employee_Name,
                e.Employee_ID,
                dp.Department_Name,
                ds.Designation_Name
            from tbl_employee_loan el
            join tbl_employee e on e.Employee_SlNo = el.Employee_SlNo
            join tbl_department dp on dp.Department_SlNo = e.Department_ID
            join tbl_designation ds on ds.Designation_SlNo = e.Designation_ID
            where el.branch_id = ?
            and el.status = 'a'
            $clauses
            order by el.id desc
        ", $this->session->userdata('BRANCHid'))->result();

        echo json_encode($payments);
    }


    public function getEmployeeLoanByEmployee()
    {
        $data = json_decode($this->input->raw_input_stream);

        $clauses = "";
        if (isset($data->employeeId) && $data->employeeId != '') {
            $clauses .= " and e.Employee_SlNo = '$data->employeeId'";
        }

        $loanAmount = $this->db->query("SELECT e.Employee_SlNo,

        (SELECT ifnull(sum(el.payment_amount),0)
         from tbl_employee_loan el
         WHERE el.Employee_SlNo = e.Employee_SlNo
         and el.status = 'a'
         and el.branch_id = '$this->brunch') as loan_amount,
         
         (SELECT ifnull(sum(ep.deduction_amount),0)
         from tbl_employee_payment ep
         WHERE ep.Employee_SlNo = e.Employee_SlNo
         and ep.status = 'a'
         and ep.payment_type = 'loan_adjust' 
         and ep.paymentBranch_id = '$this->brunch') as loan_paid,
         
         (select loan_amount - loan_paid) as current_due
         
        FROM tbl_employee e
        WHERE e.Employee_SlNo = ?
        and e.status = 'a'
        and e.Employee_brinchid = ?
            
        ", [$data->employeeId, $this->session->userdata('BRANCHid')])->row();

        echo json_encode($loanAmount);
    }

    public function employeeloanreport()
    {
        $access = $this->mt->userAccess();
        if (!$access) {
            redirect(base_url());
        }
        $data['title'] = "Employee Loan Report";
        $data['content'] = $this->load->view('Administrator/employee/employee_loan_report', $data, TRUE);
        $this->load->view('Administrator/index', $data);
    }

    public function getEmployeeLoanLedger()
    {
        $data = json_decode($this->input->raw_input_stream);

        // $clauses = "";
        // if (isset($data->employeeId) && $data->employeeId != '') {
        //     $clauses .= " and e.Employee_SlNo = '$data->employeeId'";
        // }

        $result = $this->db->query("SELECT
                'a' as sequence,
                e.Employee_ID as employee_id,
                e.Employee_Name as employee_name,
                el.payment_date as date,
                '0' as loan_paid,
                el.payment_amount as loan_taken,
                el.save_date as created_date
                from tbl_employee_loan el
                JOIN tbl_employee e on e.Employee_SlNo = el.Employee_SlNo
                WHERE el.status = 'a'
                and el.Employee_SlNo = '$data->employeeId'
                and el.branch_id = '$this->brunch'
            
                UNION
                
                SELECT
                'b' as sequence,
                e.Employee_ID as employee_id,
                e.Employee_Name as employee_name,
                ep.payment_date as date,
                ep.deduction_amount as loan_paid,
                '0' as loan_taken,
                ep.save_date as created_date
                from tbl_employee_payment ep
                JOIN tbl_employee e on e.Employee_SlNo = ep.Employee_SlNo
                WHERE ep.status = 'a'
                and ep.Employee_SlNo = '$data->employeeId'
                and ep.payment_type = 'loan_adjust'
                and ep.paymentBranch_id = '$this->brunch'
                
                order by created_date, sequence ")->result();

        echo json_encode($result);
    }
}
