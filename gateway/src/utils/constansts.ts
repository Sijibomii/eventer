let USER_SRV_IP: string='';
const loadConstants = () =>{
  if (process.env.USER_SRV_IP == '' || process.env.USER_SRV_IP == undefined){
    throw new Error("USER SRV IP MUST BE DEFINED")
  }

  USER_SRV_IP = process.env.USER_SRV_IP;

}

export { loadConstants, USER_SRV_IP }