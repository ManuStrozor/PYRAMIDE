import { LightningElement, wire } from 'lwc';
import getCustomers from '@salesforce/apex/CustomerController.getCustomers';
import LOCALE from '@salesforce/i18n/locale';
import CURRENCY from '@salesforce/i18n/currency';

const columns = [
    {label:'Customer\'s Name', fieldName:'customerLink', type:'url',
    typeAttributes:{
        label:{fieldName:'fullName'},
        tooltip:'Redirect to Customer Detail Page',
        target:'_self'
    }},
    {label:'Apartment number purchased', fieldName:'apartmentsPurchased'},
    {label:'Purchase Date', fieldName:'purchaseDate', type:'date-local'},
    {label:'Building', fieldName:'buildingLink', type:'url',
    typeAttributes:{
        label:{fieldName:'buildingName'},
        tooltip:'Redirect to Building Detail Page',
        target:'_blank'
    }},
    {label:'Paid amount', fieldName:'paidAmount', type:'currency',
    cellAttributes:{
        alignment:'left'
    }}
];

export default class Lwc01_SalesInformation extends LightningElement {
    data;
    error;
    total;
    totalAmount;
    columns = columns;

    @wire(getCustomers)
    wire_method({error, data}) {

        if(data) {

            this.data = data.map(rec => {

                return {
                    id : rec.Id,
                    customerLink : '/' + rec.Id,
                    fullName : rec.Firstname__c + ' ' + rec.Name,
                    apartmentsPurchased : rec.Apartment_number_Purchased__c,
                    purchaseDate : rec.Purchase_date__c,
                    buildingLink : '/' + rec.Building__c,
                    buildingName : rec.Building__r.Name,
                    paidAmount : rec.Amount_paid__c
                };
            });

            this.total = data.length;
            this.totalAmount = 0.0;
            for(let i in data) {
                
                this.totalAmount += data[i].Amount_paid__c;
            }
            this.totalAmount = Intl.NumberFormat(LOCALE, { style:'currency', currency:CURRENCY }).format(this.totalAmount);

            this.error = undefined;
        }
        else if(error) {
            this.error = error;
            this.data = undefined;
        }
    }
}
