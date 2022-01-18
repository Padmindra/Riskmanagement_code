using riskmanagement as rm from '../db/schema';

//Annote Risk elements
annotate rm.Risks with {

    ID @title : 'Risk';
    title @title : 'Title';
    owner @title : 'Owner';
    prio @title : 'Priority';
    descr @title : 'Description';
    miti @title : 'Mitigation';
    impact @title : 'Impact';
    bp @title : 'Business Partner';
}

//Annote Miti elements
annotate rm.Mitigations with{

    ID @(UI.Hidden,
    Commong:{Text:descr});

    owner @title : 'Owner';
    description @title : 'Description';
}


annotate rm.Risks with {

    bp @(Common:{

       Text : bp.BusinessPartner,
       TextArrangement : #TextOnly,

              ValueList : {

           Label: 'Business Partners',
           CollectionPath: 'BusinessPartners',
           
           Parameters : [

               {
                   $Type : 'Common.ValueListParameterInOut',
                   LocalDataProperty : bp_BusinessPartner,
                   ValueListProperty : 'BusinessPartner'
               },
                {
                   $Type : 'Common.ValueListParameterDisplayOnly',
                   ValueListProperty : 'LastName'
               },
                {
                   $Type : 'Common.ValueListParameterDisplayOnly',
                   ValueListProperty : 'FirstName'
               }
           ]
       },

    });
    miti @(Common : {

        //show text, not id for migitation in the context of risks
       Text : miti.description,
       TextArrangement : #TextOnly,
    
       ValueList : {

           Label: 'Mitigations',
           CollectionPath: 'Mitigations',
           
           Parameters : [

               {
                   $Type : 'Common.ValueListParameterInOut',
                   LocalDataProperty : miti_ID,
                   ValueListProperty : 'ID'
               },
                {
                   $Type : 'Common.ValueListParameterDisplayOnly',
                   ValueListProperty : 'descr'
               }
           ]
       },

       
});




}

using  from './risks/annotations';
using from './common';
