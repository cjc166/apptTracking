var mongoose = require('mongoose');
let Schema = mongoose.Schema;
let userSchema = new Schema ({
  username: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  },
  appointments: [{
    atype: String,
    office: String,
    address: String,
    phoneNumber:String,
    date: String,
    time: String
  }]
});
let User = mongoose.model('user', userSchema);

module.exports = {
  User: User
}
