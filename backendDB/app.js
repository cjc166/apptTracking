var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');
let router=express.Router;
let app = express();
app.listen(process.env.PORT || 8888);

mongoose.connect(process.env.MONGODB_URI);

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
let User = require('./models.js').User;

app.get("/", (req, res)=> {
  res.send("Welcome to ePantry backend").sendStatus(200);
})

app.post("/login", (req, res)=> {
  let username = req.body.username.toLowerCase();
  let password = req.body.password;

  User.findOne({
    username: username,
    password: password
  }).then (result => {
    res.json({userid: result._id});
  }).catch(err => {
    res.sendStatus(400).json({error: err});
  })
});

app.post("/register", (req, res) => {
  let username = req.body.username.toLowerCase();
  let password = req.body.password;

//if this username is taken
User.findOne({username: username})
.then(result=> {
  if (!result){
    let newUser = new User({
      username: username,
      password: password,
      appointments: []
    });
    newUser.save(err => {
      if (err){
        console.log(err);
      }else{
        res.sendStatus(200);
      }
    })
  }else{
    res.sendStatus(400).json({error: "This username has been taken"});
  }

}).catch(err => {
  console.log(err);
})

})

//get appointments
//delete an appointment
//create an appointment

app.get("/appointments/:userid", (req,res) => {
  let userid = req.params.userid;
  User.findById(userid)
  .then(result => {
    return result.appointments;
  }).then(appointments=>{
    res.json({appointments: appointments})
  })
  .catch(err => {
    console.log(err);
    res.sendStatus(400);
  })
});


app.post("/addAppointment/:userid",(req, res)=> {
  let userid = req.params.userid;
  let type = req.body.type;
  let office = req.body.office;
  let address = req.body.address;
  let phoneNumber = req.body.phoneNumber;
  let date = req.body.date;
  let time=req.body.time;

  console.log(type, office, address, phoneNumber, date, time)
  User.findById(userid)
  .then(result=> {
    console.log(result)

    //map the input array to the correct format for db storage
    var newAppointment = {
      atype: type,
      office: office,
      address: address,
      phoneNumber: phoneNumber,
      date: date,
      time: time,
      id: Math.random().toString(36).substring(7)
    }
    console.log(result.appointments)
    result.appointments.push(newAppointment)
  })
  .then(()=> {
    res.sendStatus(200)
  })
  .catch(err=> {
    res.json({error: err});
  })
})

//apptid - body
//userid
// app.post("/removeAppointment/:userid",(req, res)=> {
//   let userid = req.params.userid;
//   let appointmentID = req.body.apptID;
//
//   User.findById(userid)
//   .then(result => {
//
//     result.appointments = result.appointments.filter(item=> {
//       return !itemsToDelete.includes(item.itemName.toLowerCase());
//     })
//
//     result.save(err=> {
//       if (err){
//         res.sendStatus(400);
//       }else{
//         res.sendStatus(200);
//       }
//     })
//   })
// })
