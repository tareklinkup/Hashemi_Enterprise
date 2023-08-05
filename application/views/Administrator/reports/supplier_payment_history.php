<style>
    .v-select{
		margin-top:-2.5px;
        float: right;
        min-width: 180px;
        margin-left: 5px;
	}
	.v-select .dropdown-toggle{
		padding: 0px;
        height: 25px;
	}
	.v-select input[type=search], .v-select input[type=search]:focus{
		margin: 0px;
	}
	.v-select .vs__selected-options{
		overflow: hidden;
		flex-wrap:nowrap;
	}
	.v-select .selected-tag{
		margin: 2px 0px;
		white-space: nowrap;
		position:absolute;
		left: 0px;
	}
	.v-select .vs__actions{
		margin-top:-5px;
	}
	.v-select .dropdown-menu{
		width: auto;
		overflow-y:auto;
	}
	#searchForm select{
		padding:0;
		border-radius: 4px;
	}
	#searchForm .form-group{
		margin-right: 5px;
	}
	#searchForm *{
		font-size: 13px;
	}
</style>
<div id="supplierPaymentHistory">
    <div class="row">
        <div class="col-xs-12 col-md-12 col-lg-12" style="border-bottom:1px #ccc solid;">
            <form class="form-inline" id="searchForm" @submit.prevent="getSupplierPayments">
				<div class="form-group">
					<label>Supplier</label>
					<v-select v-bind:options="suppliers" v-model="selectedSupplier" label="display_name"></v-select>
                </div>
                
                <div class="form-group">
					<label>Payment Type</label>
					<select class="form-control" v-model="paymentType">
						<option value="">All</option>
						<option value="received">Received</option>
						<option value="paid">Paid</option>
					</select>
				</div>

				<div class="form-group">
					<input type="date" class="form-control" v-model="dateFrom">
				</div>

				<div class="form-group">
					<input type="date" class="form-control" v-model="dateTo">
				</div>

				<div class="form-group" style="margin-top: -5px;">
					<input type="submit" value="Search">
				</div>
			</form>
        </div>
    </div>

    <div class="row" style="display:none;" v-bind:style="{display: payments.length > 0 ? '' : 'none'}">
        <div class="col-sm-12">
            <a href="" style="margin: 7px 0;display:block;width:50px;" v-on:click.prevent="print">
                <i class="fa fa-print"></i> Print
            </a>
            <div class="table-responsive" id="reportTable">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th style="text-align:center">Transaction Id</th>
                            <th style="text-align:center">Date</th>
                            <th style="text-align:center">Supplier</th>
                            <th style="text-align:center">Transaction Type</th>
                            <th style="text-align:center">Payment by</th>
                            <th style="text-align:center">Description</th>
                            <th style="text-align:center">Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="payment in payments">
                            <td style="text-align:left;">{{ payment.SPayment_invoice }}</td>
							<td style="text-align:left;">{{ payment.SPayment_date }}</td>
							<td style="text-align:left;">{{ payment.Supplier_Code }} - {{ payment.Supplier_Name }}</td>
							<td style="text-align:left;">{{ payment.transaction_type }}</td>
							<td style="text-align:left;">{{ payment.payment_by }}</td>
							<td style="text-align:left;">{{ payment.SPayment_notes }}</td>
							<td style="text-align:right;">{{ payment.SPayment_amount }}</td>
                        </tr>
                    </tbody>
                    <tfoot v-if="paymentType != ''">
                        <tr>
                            <td colspan="6" style="text-align:right;">Total</td>
                            <td style="text-align:right;">{{ payments.reduce((p, c) => { return p + parseFloat(c.SPayment_amount)}, 0).toFixed(2) }}</td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="<?php echo base_url();?>assets/js/vue/vue.min.js"></script>
<script src="<?php echo base_url();?>assets/js/vue/axios.min.js"></script>
<script src="<?php echo base_url();?>assets/js/vue/vue-select.min.js"></script>
<script src="<?php echo base_url();?>assets/js/moment.min.js"></script>

<script>
	Vue.component('v-select', VueSelect.VueSelect);
	new Vue({
		el: '#supplierPaymentHistory',
		data(){
			return {
				suppliers: [],
				selectedSupplier: null,
				dateFrom: null,
                dateTo: null,
                paymentType: 'received',
				payments: []
			}
		},
		created(){
			this.dateFrom = moment().format('YYYY-MM-DD');
			this.dateTo = moment().format('YYYY-MM-DD');
			this.getSuppliers();
		},
		methods:{
			getSuppliers(){
				axios.get('/get_suppliers').then(res => {
					this.suppliers = res.data;
				})
			},
			getSupplierPayments(){
				let data = {
					dateFrom: this.dateFrom,
					dateTo: this.dateTo,
                    supplierId: this.selectedSupplier == null ? null : this.selectedSupplier.Supplier_SlNo,
                    paymentType: this.paymentType
				}

				axios.post('/get_supplier_payments', data).then(res => {
                    this.payments = res.data;
				})
			},
			async print(){
                let supplierText = '';
                if(this.selectedSupplier != null){
                    supplierText = `
                        <strong>Supplier Code: </strong> ${this.selectedSupplier.Supplier_Code}<br>
                        <strong>Name: </strong> ${this.selectedSupplier.Supplier_Name}<br>
                        <strong>Address: </strong> ${this.selectedSupplier.Supplier_Address}<br>
                        <strong>Mobile: </strong> ${this.selectedSupplier.Supplier_Mobile}<br>
                    `;
                }

                let dateText = '';
                if(this.dateFrom != null && this.dateTo != null){
                    dateText = `<strong>Statement from</strong> ${this.dateFrom} <strong>to</strong> ${this.dateTo}`;
                }
				let reportContent = `
					<div class="container">
						<h4 style="text-align:center">Supplier Payment History</h4 style="text-align:center">
						<div class="row">
							<div class="col-xs-6" style="font-size:12px;">
								${supplierText}
							</div>
							<div class="col-xs-6 text-right">
								${dateText}
							</div>
						</div>
					</div>
					<div class="container">
						<div class="row">
							<div class="col-xs-12">
								${document.querySelector('#reportTable').innerHTML}
							</div>
						</div>
					</div>
				`;

				var mywindow = window.open('', 'PRINT', `width=${screen.width}, height=${screen.height}`);
				mywindow.document.write(`
					<?php $this->load->view('Administrator/reports/reportHeader.php');?>
				`);

				mywindow.document.body.innerHTML += reportContent;

				mywindow.focus();
				await new Promise(resolve => setTimeout(resolve, 1000));
				mywindow.print();
				mywindow.close();
			}
		}
	})
</script>