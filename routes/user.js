const router = require('express').Router();
const path = '../views/user/';
const href = 'http://localhost:5000/';


const cquery = async  (sql,req,res)=>{
    return new Promise((resolve,reject)=>{
        connection.query(sql,(err,result)=>{
            if(err) throw err;
            resolve(result);
        })
    }
    )
}

let books = [];

router.get('/books',async(req,res)=>{
    res.render(path+'books.ejs',{path : href});
})

router.get('/home',async (req,res)=>{
    let userid=req.user.accountID;
    let temp = await cquery(`select name,address from user where userID=${userid};`);
    let name = temp[0].name;
    let address = temp[0].address;
    console.log(temp);
    res.render(path+'user_home.ejs',{path : href,name,address,userid});
});

router.get('/temp',(req,res)=>{
    res.render(path+'temp',{path : href});
})

router.post('/getbooksdata',async (req,res)=>{
    let c = req.body.criteria;
    let sub=req.body.sub;
    if(books.length == 0){
        console.log('called');
        books = await cquery('select * from book;');
    }

    if(sub.length == 0){
        res.send({});
    }else{
        let result = [];
        for(let i=0;i<books.length;i++){
            let str="";
            if(c== "Search by Name"){
                str = ""+books[i].title;
            }else{
                str = ""+books[i].authors;
            }
            books[i].rating = 4;
            console.log(books);
            if(str.indexOf(sub) > -1){
                result.push(books[i]);
            }
        }
        res.send(result);
    }

})

module.exports = router;