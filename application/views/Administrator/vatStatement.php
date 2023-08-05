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
	.record-table{
		width: 100%;
		border-collapse: collapse;
	}
	/* .record-table thead{
		background-color: #0097df;
		color:white;
	} */
	.record-table th, .record-table td{
		padding: 3px;
		border: 1px solid #454545;
	}
    .record-table th{
        text-align: center;
    }
</style>
<div id="salesRecord">
	<div class="row" style="border-bottom: 1px solid #ccc;padding: 3px 0;">
		<div class="col-md-12">
			<form class="form-inline" id="searchForm" @submit.prevent="getSearchResult">

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

	<div class="row" style="margin-top:15px;display:none;" v-bind:style="{display: sales.length > 0 ? '' : 'none'}">
		<div class="col-md-12" style="margin-bottom: 10px;">
			<a href="" @click.prevent="print"><i class="fa fa-print"></i> Print</a>
		</div>
		<div class="col-md-12">
			<div class="table-responsive" id="reportContent">
		
				<table 
					class="record-table" 
					v-if="(searchTypesForRecord.includes(searchType)) && recordType == 'without_details'" 
					style="display:none" 
					v-bind:style="{display: (searchTypesForRecord.includes(searchType)) && recordType == 'without_details' ? '' : 'none'}"
					>
					<thead>
						<tr>
							<th>Account/Group</th>
							<th>Debit</th>
							<th>Credit</th>
							<th>Closing</th>
						
						</tr>
					</thead>
					<tbody> 

				
					</tbody>
					<tfoot>
						<tr style="font-weight:bold;">
							<td style="text-align:center;">creant Asset <span style="color:red;margin-right:10px">( Sales )</span> <span style="color:#22637d">(INCL. VAT)</span></td>
							<td style="text-align:right;">{{ sales.reduce((prev, curr)=>{return prev + parseFloat(curr.SaleMaster_TotalSaleAmount)}, 0) }}</td>
							<!-- <td style="text-align:right;">{{ sales.reduce((prev, curr)=>{return prev + parseFloat(curr.SaleMaster_DueAmount)}, 0) }}</td> -->
							<td style="text-align:right;">0.00</td>
							<td style="text-align:right;">{{ sales.reduce((prev, curr)=>{return prev + parseFloat(curr.SaleMaster_TotalSaleAmount)}, 0) }}</td>
						</tr>
						<tr style="font-weight:bold;">
							<td style="text-align:center;">creant Liabilities <span style="color:red;margin-right:10px"> ( Purchase )</span> <span style="color:#22637d">(INCL. VAT)</span></td>
							<td style="text-align:right;">0.00</td>
							<td style="text-align:right;">{{ purchases.reduce((prev, curr)=>{return prev + parseFloat(curr.PurchaseMaster_TotalAmount)}, 0) }}</td>
							<!-- <td style="text-align:right;">{{ purchases.reduce((prev, curr)=>{return prev + parseFloat(curr.PurchaseMaster_DueAmount)}, 0) }}</td> -->
							<td style="text-align:right;">{{ purchases.reduce((prev, curr)=>{return prev + parseFloat(curr.PurchaseMaster_TotalAmount)}, 0) }}</td>
						</tr>
						<tr style="font-weight:bold;">
							<td style="text-align:center;">Expense <span style="color:red;margin-right:10px">( Without VAT )</td>
							<td style="text-align:right;">0.00</td>
							<td style="text-align:right;">0.00</td>
							<td style="text-align:right;">0.00</td>
						</tr>
						<tr style="font-weight:bold;">
							<td style="text-align:center;">Total</td>
							<td style="text-align:right;">{{ sales.reduce((prev, curr)=>{return prev + parseFloat(curr.SaleMaster_TotalSaleAmount)}, 0) }}</td>
							<td style="text-align:right;">{{ purchases.reduce((prev, curr)=>{return prev + parseFloat(curr.PurchaseMaster_TotalAmount)}, 0) }}</td>
							<td style="text-align:right;">{{  sales.reduce((prev, curr)=>{return prev + parseFloat(curr.SaleMaster_TotalSaleAmount)}, 0)  -  purchases.reduce((prev, curr)=>{return prev + parseFloat(curr.PurchaseMaster_TotalAmount)}, 0) }}</td>
						</tr>
                        <tr>
                            <td colspan="4" style="height: 50px;" ></td>
                        </tr>
                        <tr>
                        </tr>
					</tfoot>
				</table>

				<template>
					<table class="record-table" >
						<thead>
							<tr>
								<th></th>
								<th>Amount ( AED ) <br><span style="color:red">(INCL. VAT)</span></th>
								<th>VAT 5%</th>
							</tr>
						</thead>
						<tbody>
							<template>
								<tr>
									<td colspan="3" ></td>
								</tr>
								<tr style="font-weight:bold;">
                                    <td style="text-align:center;">Total Sale VAT</td>
                                    <td style="text-align:right;">{{  sales.reduce((prev, curr)=>{return prev + parseFloat(curr.SaleMaster_TotalSaleAmount)}, 0)  }}</td>
                                    <td style="text-align:right;">{{  parseFloat(sales.reduce((prev, curr)=>{return prev + parseFloat(curr.SaleMaster_TotalSaleAmount)}, 0) - (sales.reduce((prev, curr)=>{return prev + parseFloat(curr.SaleMaster_TotalSaleAmount)}, 0) / 1.05)).toFixed(2)}}</td>
                                </tr>
								<tr style="font-weight:bold;">
                                    <td style="text-align:center;">Total Expenses VAT</td>
                                    <td style="text-align:right;">{{ purchases.reduce((prev, curr)=>{return prev + parseFloat(curr.PurchaseMaster_TotalAmount)}, 0) }}</td>
                                    <td style="text-align:right;">{{ (purchases.reduce((prev, curr)=>{return prev + parseFloat(curr.PurchaseMaster_TotalAmount)}, 0) - (purchases.reduce((prev, curr)=>{return prev + parseFloat(curr.PurchaseMaster_TotalAmount)}, 0) / 1.05)).toFixed(2) }}</td>
                                </tr>
								<tr style="font-weight:bold;">
                                    <td style="text-align:center;">Net VAT Payable</td>
                                    <td style="text-align:right;">{{sales.reduce((prev, curr)=>{return prev + parseFloat(curr.SaleMaster_TotalSaleAmount)}, 0)  -  purchases.reduce((prev, curr)=>{return prev + parseFloat(curr.PurchaseMaster_TotalAmount)}, 0) }}</td>
                                    <td style="text-align:right;">{{ parseFloat(parseFloat(sales.reduce((prev, curr)=>{return prev + parseFloat(curr.SaleMaster_TotalSaleAmount)}, 0) - (sales.reduce((prev, curr)=>{return prev + parseFloat(curr.SaleMaster_TotalSaleAmount)}, 0) / 1.05)) - (purchases.reduce((prev, curr)=>{return prev + parseFloat(curr.PurchaseMaster_TotalAmount)}, 0) - (purchases.reduce((prev, curr)=>{return prev + parseFloat(curr.PurchaseMaster_TotalAmount)}, 0) / 1.05))).toFixed(2) }}</td>
                                </tr>
							</template>
						</tbody>
					</table>
				</template>
			</div>
		</div>
	</div>
</div>

<script src="<?php echo base_url();?>assets/js/vue/vue.min.js"></script>
<script src="<?php echo base_url();?>assets/js/vue/axios.min.js"></script>
<script src="<?php echo base_url();?>assets/js/vue/vue-select.min.js"></script>
<script src="<?php echo base_url();?>assets/js/moment.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/lodash.min.js"></script>

<script>
	Vue.component('v-select', VueSelect.VueSelect);
	new Vue({
		el: '#salesRecord',
		data(){
			return {
				searchType: '',
				recordType: 'without_details',
				dateFrom: moment().format('YYYY-MM-DD'),
				dateTo: moment().format('YYYY-MM-DD'),
				sales: [],
                purchases:[],
				searchTypesForRecord: ['', 'user', 'customer', 'employee'],
				searchTypesForDetails: ['quantity', 'category']
			}
		},
		methods: {
			getSearchResult(){
				if(this.searchType != 'customer'){
					this.selectedCustomer = null;
				}

				if(this.searchType != 'employee'){
					this.selectedEmployee = null;
				}

				if(this.searchType != 'quantity'){
					this.selectedProduct = null;
				}

				if(this.searchType != 'category'){
					this.selectedCategory = null;
				}

				if(this.searchTypesForRecord.includes(this.searchType)){
					this.getSalesRecord();
                    this.getPurchaseRecord();
				} else {
					this.getSaleDetails();
				}
			},
			getSalesRecord(){
				let filter = {
					dateFrom: this.dateFrom,
					dateTo: this.dateTo
				}

				let url = '/get_sales';
			

				axios.post(url, filter)
				.then(res => {
					if(this.recordType == 'with_details'){
						this.sales = res.data;
					} else {
						this.sales = res.data.sales;
					}
				})
				.catch(error => {
					if(error.response){
						alert(`${error.response.status}, ${error.response.statusText}`);
					}
				})
			},
            getPurchaseRecord(){
				let filter = {
					
					dateFrom: this.dateFrom,
					dateTo: this.dateTo
				}

				let url = '/get_purchases';
			

				axios.post(url, filter)
				.then(res => {
					if(this.recordType == 'with_details'){
						this.purchases = res.data;
					} else {
						this.purchases = res.data.purchases;
					}
				})
				.catch(error => {
					if(error.response){
						alert(`${error.response.status}, ${error.response.statusText}`);
					}
				})
			},
			getSaleDetails(){
				let filter = {
					categoryId: this.selectedCategory == null || this.selectedCategory.ProductCategory_SlNo == '' ? '' : this.selectedCategory.ProductCategory_SlNo,
					productId: this.selectedProduct == null || this.selectedProduct.Product_SlNo == '' ? '' : this.selectedProduct.Product_SlNo,
					dateFrom: this.dateFrom,
					dateTo: this.dateTo
				}

				axios.post('/get_saledetails', filter)
				.then(res => {
					let sales = res.data;

					if(this.selectedProduct == null) {
						sales = _.chain(sales)
							.groupBy('ProductCategory_ID')
							.map(sale => {
								return {
									category_name: sale[0].ProductCategory_Name,
									products: _.chain(sale)
										.groupBy('Product_IDNo')
										.map(product => {
											return {
												product_code: product[0].Product_Code,
												product_name: product[0].Product_Name,
												quantity: _.sumBy(product, item => Number(item.SaleDetails_TotalQuantity))
											}
										})
										.value()
								}
							})
							.value();
					}
					this.sales = sales;
				})
				.catch(error => {
					if(error.response){
						alert(`${error.response.status}, ${error.response.statusText}`);
					}
				})
			},
			deleteSale(saleId){
				let deleteConf = confirm('Are you sure?');
				if(deleteConf == false){
					return;
				}
				axios.post('/delete_sales', {saleId: saleId})
				.then(res => {
					let r = res.data;
					alert(r.message);
					if(r.success){
						this.getSalesRecord();
					}
				})
				.catch(error => {
					if(error.response){
						alert(`${error.response.status}, ${error.response.statusText}`);
					}
				})
			},
			async print(){
				let dateText = '';
				if(this.dateFrom != '' && this.dateTo != ''){
					dateText = `Statement from <strong>${this.dateFrom}</strong> to <strong>${this.dateTo}</strong>`;
				}

				let userText = '';
				if(this.selectedUser != null && this.selectedUser.FullName != '' && this.searchType == 'user'){
					userText = `<strong>Sold by: </strong> ${this.selectedUser.FullName}`;
				}

				let customerText = '';
				if(this.selectedCustomer != null && this.selectedCustomer.Customer_SlNo != '' && this.searchType == 'customer'){
					customerText = `<strong>Customer: </strong> ${this.selectedCustomer.Customer_Name}<br>`;
				}

				let employeeText = '';
				if(this.selectedEmployee != null && this.selectedEmployee.Employee_SlNo != '' && this.searchType == 'employee'){
					employeeText = `<strong>Employee: </strong> ${this.selectedEmployee.Employee_Name}<br>`;
				}

				let productText = '';
				if(this.selectedProduct != null && this.selectedProduct.Product_SlNo != '' && this.searchType == 'quantity'){
					productText = `<strong>Product: </strong> ${this.selectedProduct.Product_Name}`;
				}

				let categoryText = '';
				if(this.selectedCategory != null && this.selectedCategory.ProductCategory_SlNo != '' && this.searchType == 'category'){
					categoryText = `<strong>Category: </strong> ${this.selectedCategory.ProductCategory_Name}`;
				}


				let reportContent = `
					<div class="container">
						<div class="row">
							<div class="col-xs-12 text-center">
								<h3>Sales Record</h3>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-6">
								${userText} ${customerText} ${employeeText} ${productText} ${categoryText}
							</div>
							<div class="col-xs-6 text-right">
								${dateText}
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								${document.querySelector('#reportContent').innerHTML}
							</div>
						</div>
					</div>
				`;

				var reportWindow = window.open('', 'PRINT', `height=${screen.height}, width=${screen.width}`);
				reportWindow.document.write(`
					<?php $this->load->view('Administrator/reports/reportHeader.php');?>
				`);

				reportWindow.document.head.innerHTML += `
					<style>
						.record-table{
							width: 100%;
							border-collapse: collapse;
						}
						.record-table thead{
							background-color: #0097df;
							color:white;
						}
						.record-table th, .record-table td{
							padding: 3px;
							border: 1px solid #454545;
						}
						.record-table th{
							text-align: center;
						}
					</style>
				`;
				reportWindow.document.body.innerHTML += reportContent;

				if(this.searchType == '' || this.searchType == 'user'){
					let rows = reportWindow.document.querySelectorAll('.record-table tr');
					rows.forEach(row => {
						row.lastChild.remove();
					})
				}


				reportWindow.focus();
				await new Promise(resolve => setTimeout(resolve, 1000));
				reportWindow.print();
				reportWindow.close();
			}
		}
	})
</script>