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
    //jshint ignore:start
    data;
    error;
    totalAmount;
    columns = columns;

    @wire(getCustomers)
    //jshint ignore:end
    wire_method({error, data}) {

        if(data) {

            this.data = data.map(rec => {

                this.totalAmount = Number(this.totalAmount | 0) + Number(rec.Amount_paid__c | 0);

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
            
            this.error = undefined;
        }
        else if(error) {

            this.totalAmount = 0;
            this.error = error;
            this.data = undefined;
        }
    }

    get formatedAmount() {

        return Intl.NumberFormat(LOCALE, { style:'currency', currency:CURRENCY }).format(this.totalAmount);
    }
}
