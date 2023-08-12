<style>
.v-select {
    margin-bottom: 5px;
}

.v-select.open .dropdown-toggle {
    border-bottom: 1px solid #ccc;
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

#suppliers label {
    font-size: 13px;
}

#suppliers select {
    border-radius: 3px;
}

#suppliers .add-button {
    padding: 2.5px;
    width: 28px;
    background-color: #298db4;
    display: block;
    text-align: center;
    color: white;
}

#suppliers .add-button:hover {
    background-color: #41add6;
    color: white;
}

#suppliers input[type="file"] {
    display: none;
}

#suppliers .custom-file-upload {
    border: 1px solid #ccc;
    display: inline-block;
    padding: 5px 12px;
    cursor: pointer;
    margin-top: 5px;
    background-color: #298db4;
    border: none;
    color: white;
}

#suppliers .custom-file-upload:hover {
    background-color: #41add6;
}

#supplierImage {
    height: 100%;
}
</style>
<div id="suppliers">
    <form @submit.prevent="saveSupplier">
        <div class="row" style="margin-top: 10px;margin-bottom:15px;border-bottom: 1px solid #ccc;padding-bottom:15px;">
            <div class="col-md-5">

                <div class="form-group clearfix">
                    <label class="control-label col-md-4">Supplier Name:</label>
                    <div class="col-md-7">
                        <v-select v-bind:options="suppliers" v-model="selectedSupplier" label="display_name">
                        </v-select>
                    </div>
                </div>

                <div class="form-group clearfix">
                    <label class="control-label col-md-4">Cheque No</label>
                    <div class="col-md-7">
                        <input type="text" class="form-control" v-model="supplier.cheque_no">
                    </div>
                </div>

                <div class="form-group clearfix">
                    <label class="control-label col-md-4">Address:</label>
                    <div class="col-md-7">
                        <input type="text" class="form-control" v-model="supplier.address">
                    </div>
                </div>
            </div>

            <div class="col-md-5">
                <div class="form-group clearfix">
                    <label class="control-label col-md-4">Bank Name:</label>
                    <div class="col-md-7">
                        <input type="text" class="form-control" v-model="supplier.bank_name" required>
                    </div>
                </div>

                <div class="form-group clearfix">
                    <label class="control-label col-md-4">Amount:</label>
                    <div class="col-md-7">
                        <input type="text" class="form-control" v-model="supplier.amount">
                    </div>
                </div>

                <div class="form-group clearfix">
                    <label class="control-label col-md-4">Description</label>
                    <div class="col-md-7">
                        <input type="text" class="form-control" v-model="supplier.description" required>
                    </div>
                </div>

                <div class="form-group clearfix">
                    <div class="col-md-7 col-md-offset-4">
                        <input type="submit" class="btn btn-success btn-sm" value="Save">
                    </div>
                </div>
            </div>
        </div>
    </form>

    <div class="row">
        <div class="col-sm-12 form-inline">
            <div class="form-group">
                <label for="filter" class="sr-only">Filter</label>
                <input type="text" class="form-control" v-model="filter" placeholder="Filter">
            </div>
        </div>

        <div class="col-md-12">
            <a href="" v-on:click.prevent="print"><i class="fa fa-print"></i> Print</a>
        </div>
        <div class="col-md-12">
            <div class="table-responsive" id="chequeList">
                <datatable :columns="columns" :data="suppliersCheque" :filter-by="filter" style="margin-bottom: 5px;">
                    <template scope="{ row }">
                        <tr>
                            <td>{{ row.Supplier_SlNo }}</td>
                            <td>{{ row.Supplier_Name }}</td>
                            <td>{{ row.cheque_no }}</td>
                            <td>{{ row.amount }}</td>
                            <td>{{ row.address }}</td>
                            <td>{{ row.bank_name }}</td>
                            <td>{{ row.description }}</td>
                            <td>
                                <?php if($this->session->userdata('accountType') != 'u'){?>
                                <button type="button" class="button edit" @click="editSupplier(row)">
                                    <i class="fa fa-pencil"></i>
                                </button>
                                <button type="button" class="button" @click="deleteSupplier(row.Cheque_SlNo)">
                                    <i class="fa fa-trash"></i>
                                </button>
                                <?php }?>
                            </td>
                        </tr>
                    </template>
                </datatable>
                <datatable-pager v-model="page" type="abbreviated" :per-page="per_page" style="margin-bottom: 50px;">
                </datatable-pager>
            </div>
        </div>
    </div>
</div>

<script src="<?php echo base_url();?>assets/js/vue/vue.min.js"></script>
<script src="<?php echo base_url();?>assets/js/vue/axios.min.js"></script>
<script src="<?php echo base_url();?>assets/js/vue/vuejs-datatable.js"></script>
<script src="<?php echo base_url();?>assets/js/vue/vue-select.min.js"></script>
<script src="<?php echo base_url();?>assets/js/moment.min.js"></script>

<script>
Vue.component('v-select', VueSelect.VueSelect);
new Vue({
    el: '#suppliers',
    data() {
        return {
            supplier: {
                Cheque_SlNo: 0,
                supplier_id: '',
                address: '',
                cheque_no: '',
                description: '',
                bank_name: '',
                amount: 0.00
            },
            suppliers: [],
            suppliersCheque: [],
            selectedSupplier: null,
            columns: [{
                    label: 'Supplier Id',
                    field: 'Supplier_SlNo',
                    align: 'center',
                    filterable: false
                },
                {
                    label: 'Supplier Name',
                    field: 'Supplier_Name',
                    align: 'center'
                },
                {
                    label: 'Cheque No',
                    field: 'cheque_no',
                    align: 'center'
                },
                {
                    label: 'Amount',
                    field: 'amount',
                    align: 'center'
                },
                {
                    label: 'Address',
                    field: 'address',
                    align: 'center'
                },
                {
                    label: 'Bank Name',
                    field: 'bank_name',
                    align: 'center'
                },
                {
                    label: 'Description',
                    field: 'description',
                    align: 'center'
                },
                {
                    label: 'Action',
                    align: 'center',
                    filterable: false
                }
            ],
            page: 1,
            per_page: 10,
            filter: ''
        }
    },
    created() {
        this.getSuppliers();
        this.getSuppliersCheque();
    },
    methods: {

        getSuppliers() {
            axios.get('/get_suppliers').then(res => {
                this.suppliers = res.data;
            })
        },

        saveSupplier() {

            let url = '/add_supplier_cheque';
            if (this.supplier.Cheque_SlNo != 0) {
                url = '/update_supplier_cheque';
            }

            this.supplier.supplier_id = this.selectedSupplier.Supplier_SlNo;

            let fd = {
                supplier: this.supplier
            }



            axios.post(url, this.supplier).then(res => {
                let r = res.data;
                alert(r.message);
                if (r.success) {
                    this.resetForm();
                    this.getSuppliersCheque();
                }
            })
        },

        getSuppliersCheque() {
            axios.get('/get_suppliers_cheque').then(res => {
                this.suppliersCheque = res.data;
            })
        },

        editSupplier(supplier) {

            let keys = Object.keys(this.supplier);
            keys.forEach(key => {
                this.supplier[key] = supplier[key];
            })

            if (supplier.image_name == null || supplier.image_name == '') {
                this.imageUrl = null;
            } else {
                this.imageUrl = '/uploads/suppliers/' + supplier.image_name;
            }

            this.selectedSupplier = {
                Supplier_SlNo: supplier.supplier_id,
                display_name: supplier.Supplier_Name,
            }
        },
        deleteSupplier(supplierId) {
            let deleteConfirm = confirm('Are you sure?');
            if (deleteConfirm == false) {
                return;
            }
            axios.post('/delete_supplier_cheque', {
                supplierId: supplierId
            }).then(res => {
                let r = res.data;
                alert(r.message);
                if (r.success) {
                    this.getSuppliersCheque();
                }
            })
        },
        resetForm() {
            let keys = Object.keys(this.supplier);
            keys.forEach(key => {
                if (typeof(this.supplier[key]) == 'string') {
                    this.supplier[key] = '';
                } else if (typeof(this.supplier[key]) == 'number') {
                    this.supplier[key] = 0;
                }
            })
            this.selectedSupplier = null;
        },

        async print() {

            let reportContent = `
					<div class="container">
						<h4 style="text-align:center">Supplier Cheque List Report</h4 style="text-align:center">
					</div>
					<div class="container">
						<div class="row">
							<div class="col-xs-12">
								${document.querySelector('#chequeList').innerHTML}
							</div>
						</div>
					</div>
				`;

            var reportWindow = window.open('', 'PRINT',
                `height=${screen.height}, width=${screen.width}, left=0, top=0`);
            reportWindow.document.write(`
					<?php $this->load->view('Administrator/reports/reportHeader.php');?>
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