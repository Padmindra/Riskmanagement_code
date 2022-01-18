/* eslint-disable no-empty */
//Imports
const cds = require("@sap/cds");

module.exports = cds.service.impl(
    async function(){

        const {Risks,BusinessPartners}=this.entities;
        //const {Risks}=this.entities;
        //set critically after a READ ooperation on risks.
        
        this.after("READ",Risks,(data)=>{
            const risks=Array.isArray(data)?data:[data];
            risks.forEach((risk) => {
                if(risk.impact>100000){
                    risk.criticality =1;
                }else{
                    risk.criticality = 2;
                }

            });

        });

        //connect to remote service below code will display all the business from API
    const BPsrv=await cds.connect.to("API_BUSINESS_PARTNER");

    //Event handler for read events on the business partner entities
    this.on("READ",BusinessPartners, async (req)=>{
        req.query.where("LastName <> '' and FirstName <> '' ");

        return await BPsrv.transaction(req).send({
            query:req.query
        });
    });
    
   /* this.on("READ",BusinessPartners, async (req)=>{
    try{
            
        
        const res = await next();
        await Promise.all(
            res.map(async (risk)=>{
                const bp = await BPsrv.transaction(req).send({
                    query:SELECT.one(this.entities.BusinessPartners).
                    where({BusinessPartners:risk.bp_BusinessPartner}).
                    columns(["BusinessPartner","LastName","FirstName"])
                });
                risk.bp=bp;
            })

        )

    }catch(error){}
   });*/
   
  
});






