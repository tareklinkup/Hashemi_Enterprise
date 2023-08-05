<style>
    .widgets {
        width: 100%;
        min-height: 100px;
        padding: 15px;
        display: flex;
        justify-content: center;
        align-items: center;
        box-shadow: 0px 1px 2px #454545;
        border-radius: 3px;
    }
    .widgets .widget-icon {
        width: 60px;
        height: 60px;
        padding: 10px;
        border-radius: 50%;
        color: white;
        margin-right: 10px;
    }
    .widgets .widget-content {
        flex-grow: 2;
        font-weight: bold;
    }
    .widgets .widget-content .widget-text {
        color: #6f6f6f;
    }
    .widgets .widget-content .widget-value {
        font-size: 20px;
    }
</style>
<div id="graph">
    <div class="row" v-if="showData" style="display:none;" v-bind:style="{ display: showData ? '' : 'none' }">
        <div class="col-md-12">
            <marquee direction="left" height="30" bgcolor="black" style="color:white;padding-top:5px;margin-bottom: 15px;">{{ salesText }}</marquee>
        </div>
    </div>
    <div class="row" v-if="showData" style="display:none;" v-bind:style="{ display: showData ? '' : 'none' }">
        <div class="col-md-3">
            <div class="widgets" style="border-top: 5px solid #1c8dff;">
                <div class="widget-icon" style="background-color: #1c8dff;text-align:center;">
                    <i class="fa fa-shopping-cart fa-3x"></i>
                </div>
                
                <div class="widget-content">
                    <div class="widget-text">Today's Sale</div>
                    <div class="widget-value">tk. {{ todaysSale }}</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="widgets" style="border-top: 5px solid #ff8000;">
                <div class="widget-icon" style="background-color: #ff8000;text-align:center;">
                    <i class="fa fa-money fa-3x"></i>
                </div>
                
                <div class="widget-content">
                    <div class="widget-text">Today's Cash Collection</div>
                    <div class="widget-value">tk. {{ todaysCollection }}</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="widgets" style="border-top: 5px solid #008241;">
                <div class="widget-icon" style="background-color: #008241;text-align:center;">
                    <i class="fa fa-shopping-cart fa-3x"></i>
                </div>
                
                <div class="widget-content">
                    <div class="widget-text">This Month's Sale</div>
                    <div class="widget-value">tk. {{ thisMonthSale }}</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="widgets" style="border-top: 5px solid #ae0000;">
                <div class="widget-icon" style="background-color: #ae0000;text-align:center;">
                    <i class="fa fa-dollar fa-3x"></i>
                </div>
                
                <div class="widget-content">
                    <div class="widget-text">Cash Balance</div>
                    <div class="widget-value">tk. {{ cashBalance }}</div>
                </div>
            </div>
        </div>
    </div>
    <div class="row" style="margin-bottom: 25px;">
        <div class="col-md-12">
            <h3 class="text-center">This Month's Sale</h3>
            <sales-chart
            type="ColumnChart"
            :data="salesData"
            :options="salesChartOptions"
            />
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <h3 class="text-center">Top Sold Products</h3>
            <top-product-chart
            type="PieChart"
            :data="topProducts"
            :options="topProductsOptions"
            />
        </div>
        <div class="col-md-6">
            <h3 class="text-center">Top Customers</h3>
            <top-customer-chart
            type="PieChart"
            :data="topCustomers"
            :options="topCustomersOptions"
            />
        </div>
    </div>
</div>

<script src="<?php echo base_url();?>assets/js/vue/vue.min.js"></script>
<script src="<?php echo base_url();?>assets/js/vue/axios.min.js"></script>
<script src="<?php echo base_url();?>assets/js/moment.min.js"></script>
<script src="<?php echo base_url();?>assets/js/vue/components/vue-google-charts.browser.js"></script>

<script>
    let googleChart = VueGoogleCharts.GChart;
    new Vue({
        el: '#graph',
        components: {
            'sales-chart': googleChart,
            'top-product-chart': googleChart,
            'top-customer-chart': googleChart
        },
        data () {
            return {
                salesData: [
                    ['Date', 'Sales']
                ],
                salesChartOptions: {
                    chart: {
                        title: 'Sales',
                        subtitle: "This month's sales data",
                    }
                },
                topProducts: [
                    ['Product', 'Quantity']
                ],
                topProductsOptions: {
                    chart: {
                        title: 'Top Sold Products',
                        subtitle: "Top sold products"
                    }
                },
                topCustomers: [
                    ['Customer', 'Amount']
                ],
                topCustomersOptions: {
                    chart: {
                        title: 'Top Sold Products',
                        subtitle: "Top sold products"
                    }
                },
                salesText: '',
                todaysSale: 0,
                thisMonthSale: 0,
                todaysCollection: 0,
                cashBalance: 0,
                showData: false
            }
        },
        created(){
            this.getGraphData();
            setInterval(() => {
                this.getGraphData();
            }, 10000);
        },
        methods: {
            getGraphData(){
                axios.get('/get_graph_data').then(res => {
                    this.salesData = [
                        ['Date', 'Sales']
                    ]
                    res.data.monthly_record.forEach(d => {
                        this.salesData.push(d);
                    })

                    this.salesText = res.data.sales_text.map(sale => {
                        return sale.sale_text;
                    }).join(' | ');

                    this.todaysSale = res.data.todays_sale;
                    this.thisMonthSale = res.data.this_month_sale;
                    this.todaysCollection = res.data.todays_collection;
                    this.cashBalance = res.data.cash_balance;

                    this.topCustomers = [
                        ['Customer', 'Amount']
                    ]
                    res.data.top_customers.forEach(c => {
                        this.topCustomers.push([c.customer_name, parseFloat(c.amount)]);
                    })

                    this.topProducts = [
                        ['Product', 'Quantity']
                    ]
                    res.data.top_products.forEach(p => {
                        this.topProducts.push([p.product_name, parseFloat(p.sold_quantity)]);
                    })

                    this.showData = true;
                })
            }
        }
    })
</script>
