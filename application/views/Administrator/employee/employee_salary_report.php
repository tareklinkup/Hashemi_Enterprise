<style>
	.v-select {
		margin-bottom: 5px;
		float: right;
		min-width: 200px;
		margin-left: 5px;
	}

	.v-select .dropdown-toggle {
		padding: 0px;
		height: 25px;
	}

	.v-select input[type=search],
	.v-select input[type=search]:focus {
		margin: 0px;
	}

	.v-select .vs__selected-options {
		overflow: hidden;
		flex-wrap: nowrap;
	}

	.v-select .selected-tag {
		margin: 2px 0px;
		white-space: nowrap;
		position: absolute;
		left: 0px;
	}

	.v-select .vs__actions {
		margin-top: -5px;
	}

	.v-select .dropdown-menu {
		width: auto;
		overflow-y: auto;
	}

	#salaryReport label {
		font-size: 13px;
		margin-top: 3px;
	}

	#salaryReport select {
		border-radius: 3px;
		padding: 0px;
		font-size: 13px;
	}

	#salaryReport .form-group {
		margin-right: 10px;
	}
</style>

<div id="salaryReport">
	<div class="row" style="border-bottom:1px solid #ccc;padding: 10px 0;">
		<div class="col-md-12">
			<form class="form-inline" @submit.prevent="showReport">
				<div class="form-group" style="display: none;">
					<label>Report Type</label>
					<select class="form-control" v-model="reportType" @change="onChangeReportType">
						<option value="records">Payment Records</option>
						<option value="summary">Salary Summary</option>
					</select>
				</div>
				<div class="form-group">
					<label>Employee</label>
					<select class="form-control" style="min-width:200px;" v-bind:style="{display: comEmployees.length > 0 ? 'none' : ''}"></select>
					<v-select v-bind:options="comEmployees" v-model="selectedEmployee" label="display_text" style="display:none" v-bind:style="{display: comEmployees.length > 0 ? '' : 'none'}"></v-select>
				</div>

				<div class="form-group">
					<label>Month</label>
					<select class="form-control" style="min-width:150px;" v-bind:style="{display: months.length > 0 ? 'none' : ''}"></select>
					<v-select v-bind:options="months" v-model="selectedMonth" label="month_name" style="display:none" v-bind:style="{display: months.length > 0 ? '' : 'none'}"></v-select>
				</div>
				<!-- <div class="form-group">
					<label>Date from</label>
					<input type="date" class="form-control" v-model="dateFrom">
				</div>
				<div class="form-group">
					<label>to</label>
					<input type="date" class="form-control" v-model="dateTo">
				</div> -->

				<div class="form-group" style="margin-top: -5px;">
					<input type="submit" class="search-button" value="Search">
				</div>
			</form>
		</div>
	</div>

	<div class="row" style="margin-top: 10px;display:none;" v-bind:style="{display: payments.length > 0 ? '' : 'none'}">
		<div class="col-md-12">
			<a href="" @click.prevent="print"><i class="fa fa-print"></i> Print</a>
		</div>
		<div class="col-md-12">
			<div class="table-responsive" id="reportContent">
				<div>
					<h3 style="text-align:center;">Payment Records</h3>
					<table class="table table-bordered table-condensed">
						<thead>
							<tr>
								<th>Sl</th>
								<th>Employee Id</th>
								<th>Employee Name</th>
								<th>Department</th>
								<th>Designation</th>
								<th>Payment Date</th>
								<th>Note</th>
								<th>Month</th>
								<th>Salary</th>
								<th>Deduct</th>
								<th>Paid</th>
								<th>Balance</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="(payment, sl) in payments">
								<td>{{ sl + 1 }}</td>
								<td>{{ payment.Employee_ID }}</td>
								<td>{{ payment.Employee_Name }}</td>
								<td>{{ payment.Department_Name }}</td>
								<td>{{ payment.Designation_Name }}</td>
								<td>{{ payment.payment_date }}</td>
								<td style="text-align:right;">{{ payment.payment_type }}</td>
								<!-- <td style="text-align:right;">{{ payment.Note }}</td> -->
								<td>{{ payment.month_name }}</td>
								<td>{{ payment.salary_range == '0' ? '' : payment.salary_range}}</td>
								<td style="text-align:right;">{{ payment.deduction_amount }}</td>
								<td style="text-align:right;">{{ payment.payment_amount }}</td>
								<td style="text-align:right;">{{ parseFloat(payment.balance).toFixed(2) }}</td>
							</tr>
						</tbody>
						<tfoot>
							<tr style="font-weight:bold;" v-if="payments.length > 0">
								<td colspan="8" style="text-align:right;">Total</td>
								<!-- <td style="text-align:right;">{{ payments.reduce((prev, curr) => { return prev + parseFloat(curr.deduction_amount)}, 0).toFixed(2) }}</td> -->
								<td style="text-align:right;">{{ payments.reduce((prev, curr) => { return prev + parseFloat(curr.payment_amount)}, 0).toFixed(2) }}</td>
								<td style="text-align:right;">{{ payments.reduce((prev, curr) => { return prev + parseFloat(curr.deduction_amount)}, 0).toFixed(2) }}</td>
								<td style="text-align:right;">{{ payments.reduce((prev, curr) => { return prev + parseFloat(curr.salary_range)}, 0).toFixed(2) }}</td>
								<td style="text-align:right;"></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="<?php echo base_url(); ?>assets/js/vue/vue.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/vue/axios.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/vue/vue-select.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/moment.min.js"></script>

<script>
	Vue.component('v-select', VueSelect.VueSelect);
	new Vue({
		el: '#salaryReport',
		data() {
			return {
				employees: [],
				selectedEmployee: null,
				months: [],
				selectedMonth: null,
				payments: [],
				paymentSummary: [],
				reportType: 'records',
				dateTo: moment().format("YYYY-MM-DD"),
				dateFrom: moment().format("YYYY-MM-DD")
			}
		},
		computed: {
			comEmployees() {
				return this.employees.map(employee => {
					employee.display_text = employee.Employee_SlNo == '' ? employee.Employee_Name : `${employee.Employee_Name} - ${employee.Employee_ID}`;
					return employee;
				})
			}
		},
		created() {
			this.getEmployees();
			this.getMonths();
		},
		methods: {
			getEmployees() {
				axios.get('/get_employees').then(res => {
					this.employees = res.data;
				})
			},
			getMonths() {
				axios.get('/get_months').then(res => {
					this.months = res.data;
					this.months.unshift({
						month_id: '',
						month_name: 'All'
					})
				})
			},
			onChangeReportType() {
				if (this.reportType == 'summary') {
					this.months = this.months.filter(month => month.month_id != '');
					this.paymentSummary = [];
				} else {
					this.months.unshift({
						month_id: '',
						month_name: 'All'
					})
					this.payments = [];
				}
			},
			showReport() {
				if (this.reportType == 'records') {
					this.getEmployeePayments();
				} else {
					this.getSalarySummary();
				}
			},
			getEmployeePayments() {
				let data = {}
				if (this.selectedEmployee == null) {
					alert("Select employee");
					return;
				}

				data.monthId = this.selectedMonth == null ? null : this.selectedMonth.month_id;
				// data.dateFrom = this.dateFrom;
				// data.dateTo = this.dateTo;
				data.employeeId = this.selectedEmployee == null ? null : this.selectedEmployee.Employee_SlNo;


				axios.post('/get_employee_ledger', data)
					.then(res => {
						this.payments = res.data;
					})
			},
			getSalarySummary() {
				if (this.selectedMonth == null || this.selectedMonth.month_id == '') {
					alert('Select month');
					return;
				}
				let data = {
					monthId: this.selectedMonth.month_id,
					monthName: this.selectedMonth.month_name
				}
				axios.post('/get_salary_summary', data)
					.then(res => {
						this.paymentSummary = res.data;
					})
					.catch(error => {
						if (error.response) {
							alert(`${error.response.status}, ${error.response.statusText}`);
						}
					})
			},
			async print() {
				let reportContent = `
					<div class="container">
						<div class="row">
							<div class="col-xs-12">
								${document.querySelector('#reportContent').innerHTML}
							</div>
						</div>
					</div>
				`;

				var reportWindow = window.open('', 'PRINT', `height=${screen.height}, width=${screen.width}, left=0, top=0`);
				reportWindow.document.write(`
					<?php $this->load->view('Administrator/reports/reportHeader.php'); ?>
				`);

				reportWindow.document.body.innerHTML += reportContent;

				reportWindow.focus();
				await new Promise(resolve => setTimeout(resolve, 1000));
				reportWindow.print();
				reportWindow.close();
			}
		}
	})
</script>