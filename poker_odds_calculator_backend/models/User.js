const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const UserSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    password: { type: String, required: false },
    email: { type: String, required: true, unique: true }
});


UserSchema.pre('save', async function(next) {
    const user = this;
    if (!user.isModified('password')) return next();
    const salt = await bcrypt.genSalt(10);
    print(user.password);
    user.password = await bcrypt.hash(user.password, salt);
    next();
});

const User = mongoose.model('User', UserSchema);
module.exports = User;
