const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const bodyParser = require('body-parser');

const app = express();
const PORT = 8080;

app.use(bodyParser.json());
const uri = "mongodb+srv://durmatekin22:3pmJcBeFZEJYAqFa@cluster0.wzrd7.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"

mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('MongoDB bağlantısı başarılı.'))
    .catch(err => {
        console.log('MongoDB bağlantısı başarısız:', err);
        process.exit(1);
    });

const UserSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    email: { type: String, required: true, unique: true }
});

const User = mongoose.model('User', UserSchema); 

app.post('/register', async (req, res) => {
    const { username, password, email } = req.body;

    console.log('Gelen veri:', req.body);

    const existingUser = await User.findOne({ $or: [{ username }, { email }] });
    if (existingUser) {
        if (existingUser.username === username) {
            return res.status(400).json({ message: 'Bu kullanıcı adı zaten kayıtlı.' });
        }
        if (existingUser.email === email) {
            return res.status(400).json({ message: 'Bu email adresi zaten kayıtlı.' });
        }
    }

    if (!password || password.trim() === '') {
        return res.status(400).json({ message: 'Şifre gerekli.' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    
    const newUser = new User({ username, password: hashedPassword, email });
    
    try {
        const savedUser = await newUser.save();
        res.status(201).json({ message: 'Kullanıcı başarıyla kaydedildi.', _id: savedUser._id }); 
    } catch (error) {
        console.error('Kullanıcı kaydedilemedi:', error); 
        res.status(400).json({ message: 'Kullanıcı kaydedilemedi.', error });
    }
});


app.post('/login', async (req, res) => {
    const { username, password } = req.body;
    
    try {
        const user = await User.findOne({ username });
        if (!user) {
            return res.status(400).json({ message: 'Kullanıcı bulunamadı.' });
        }
        
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Şifre yanlış.' });
        }
        
        res.status(200).json({ message: 'Giriş başarılı.', _id: user._id });
    } catch (error) {
        res.status(500).json({ message: 'Sunucu hatası.', error: error.message });
    }
});


app.put('/update/:id', async (req, res) => {
    const { username, email } = req.body;
    
    try {
        const updatedUser = await User.findByIdAndUpdate(req.params.id, { username, email }, { new: true });
        if (!updatedUser) {
            return res.status(404).json({ message: 'Kullanıcı bulunamadı.' });
        }
        res.status(200).json({ message: 'Kullanıcı başarıyla güncellendi.', user: updatedUser });
    } catch (error) {
        res.status(400).json({ message: 'Güncelleme hatası.', error });
    }
});

app.listen(PORT, () => {
    console.log(`Sunucu http://localhost:${PORT} adresinde çalışıyor.`);
});
