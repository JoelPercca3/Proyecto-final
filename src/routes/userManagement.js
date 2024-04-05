import express from 'express'
import { pool } from './config/db.js'
import { admin } from './library.js'

const app = express()
app.use(express.json())

// Registrar un nuevo usuario
app.post('/usuarios/registro', async (req, res) => {
  const { email, password, nombre, apellido } = req.body

  try {
    await pool.query('INSERT INTO usuarios (email, password, nombre, apellido) VALUES (?, ?, ?, ?)', [email, password, nombre, apellido])
    res.json({ message: 'Usuario registrado correctamente' })
  } catch (error) {
    return res.status(500).json({ message: 'Error al registrar el usuario' })
  }
})

// Actualizar datos personales del usuario
app.put('/usuarios/:id', async (req, res) => {
  const userId = req.params.id
  const { email, password, nombre, apellido } = req.body

  try {
    await pool.query('UPDATE usuarios SET email = ?, password = ?, nombre = ?, apellido = ? WHERE id = ?', [email, password, nombre, apellido, userId])
    res.json({ message: 'Datos actualizados correctamente' })
  } catch (error) {
    return res.status(500).json({ message: 'Error al actualizar los datos del usuario' })
  }
})

// Eliminar cuenta de usuario
app.delete('/usuarios/:id', async (req, res) => {
  const userId = req.params.id

  try {
    await pool.query('DELETE FROM usuarios WHERE id = ?', [userId])
    res.json({ message: 'Cuenta de usuario eliminada correctamente' })
  } catch (error) {
    return res.status(500).json({ message: 'Error al eliminar la cuenta de usuario' })
  }
})

// Ver todos los usuarios (solo para administradores)
app.get('/usuarios', async (req, res) => {
  const { userEmail, userPassword } = req.body

  try {
    const isAdmin = await admin(userEmail, userPassword, res)
    if (!isAdmin) {
      return res.status(403).json({ message: 'Permiso denegado para esta acción' })
    }

    const [usuarios] = await pool.query('SELECT * FROM usuarios')
    res.json(usuarios)
  } catch (error) {
    return res.status(500).json({ message: 'Error al obtener los usuarios' })
  }
})

export default app
