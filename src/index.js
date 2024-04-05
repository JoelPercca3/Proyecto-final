import express from 'express'
import { PORT } from './config/config.js'
import { pool } from './config/db.js'
import { admin } from './library.js'
const app = express()

app.use(express.json())

app.get('/', (req, res) => { req.send('Hello World') })

app.get('/categorias', async (req, res) => {
  const [categorias] = await pool.query('SELECT * FROM categorias')
  res.json(categorias)
})

app.post('/categorias', async (req, res) => {
  const { userEmail, userPassword, nombre } = req.body

  try {
    const isAdmin = await admin(userEmail, userPassword, res)
    if (!isAdmin) {
      return res.status(403).json({ message: 'permiso denegado para esta accion' })
    }

    const [categoria] = await pool.query('INSERT INTO categorias(nombre) VALUES (?)', [nombre])
    res.json(categoria)
  } catch (error) {
    return res.status(401).json({ message: error.message })
  }
})

// Crear nueva publicación
app.post('/publicaciones', async (req, res) => {
  const { userEmail, userPassword, titulo, contenido, usuarioId } = req.body

  try {
    const isAdmin = await admin(userEmail, userPassword, res)
    if (!isAdmin) {
      return res.status(403).json({ message: 'Permiso denegado para esta acción' })
    }

    const fechaCreacion = new Date().toISOString().slice(0, 19).replace('T', ' ')
    const [result] = await pool.query('INSERT INTO publicaciones (titulo, contenido, usuario_id, fecha_creacion) VALUES (?, ?, ?, ?)', [titulo, contenido, usuarioId, fechaCreacion])
    res.json({ id: result.insertId, titulo, contenido, usuarioId, fechaCreacion })
  } catch (error) {
    return res.status(401).json({ message: error.message })
  }
})

// Actualizar publicacion
app.put('/publicaciones/:id', async (req, res) => {
  const { userEmail, userPassword, titulo, contenido } = req.body
  const postId = req.params.id

  try {
    const isAdmin = await admin(userEmail, userPassword, res)
    if (!isAdmin) {
      return res.status(403).json({ message: 'Permiso denegado para esta acción' })
    }

    await pool.query('UPDATE publicaciones SET titulo = ?, contenido = ? WHERE id = ?', [titulo, contenido, postId])
    res.json({ id: postId, titulo, contenido })
  } catch (error) {
    return res.status(401).json({ message: error.message })
  }
})

// Eliminar publicación
app.delete('/publicaciones/:id', async (req, res) => {
  const { userEmail, userPassword } = req.body
  const postId = req.params.id

  try {
    const isAdmin = await admin(userEmail, userPassword, res)
    if (!isAdmin) {
      return res.status(403).json({ message: 'Permiso denegado para esta acción' })
    }

    await pool.query('DELETE FROM publicaciones WHERE id = ?', [postId])
    res.json({ message: 'Publicación eliminada correctamente' })
  } catch (error) {
    return res.status(401).json({ message: error.message })
  }
})

// Ver todas las publicaciones
app.get('/publicaciones', async (req, res) => {
  try {
    const [publicaciones] = await pool.query('SELECT * FROM publicaciones')
    res.json(publicaciones)
  } catch (error) {
    return res.status(500).json({ message: 'Error al obtener las publicaciones' })
  }
})

// Ver publicaciones de un usuario específico
app.get('/publicaciones/usuario/:id', async (req, res) => {
  const userId = req.params.id

  try {
    const [publicaciones] = await pool.query('SELECT * FROM publicaciones WHERE usuario_id = ?', [userId])
    res.json(publicaciones)
  } catch (error) {
    return res.status(500).json({ message: 'Error al obtener las publicaciones del usuario' })
  }
})

// Filtrar publicaciones por categoría
app.get('/publicaciones/categoria/:categoriaId', async (req, res) => {
  const categoriaId = req.params.categoriaId

  try {
    const [publicaciones] = await pool.query('SELECT * FROM publicaciones WHERE categoria_id = ?', [categoriaId])
    res.json(publicaciones)
  } catch (error) {
    return res.status(500).json({ message: 'Error al obtener las publicaciones de la categoría' })
  }
})

// Buscar publicaciones por título
app.get('/publicaciones/buscar', async (req, res) => {
  const { titulo } = req.query

  try {
    const [publicaciones] = await pool.query('SELECT * FROM publicaciones WHERE titulo LIKE ?', [`%${titulo}%`])
    res.json(publicaciones)
  } catch (error) {
    return res.status(500).json({ message: 'Error al buscar las publicaciones' })
  }
})

// Ruta para agregar un nuevo comentario a una publicación

app.post('/comentarios', async (req, res) => {
  const { contenido, usuarioId, publicacionId } = req.body

  try {
    // Insertar el nuevo comentario en la base de datos
    const result = await pool.query('INSERT INTO comentarios (contenido, usuario_id, publicacion_id) VALUES (?, ?, ?)', [contenido, usuarioId, publicacionId])

    // Devolver el ID del comentario creado
    res.json({ id: result.insertId, message: 'Comentario agregado correctamente' })
  } catch (error) {
    // Manejar errores
    console.error('Error al agregar el comentario:', error)
    res.status(500).json({ message: 'Error al agregar el comentario' })
  }
})

// Ruta para actualizar un comentario existente
app.put('/comentarios/:id', async (req, res) => {
  const comentarioId = req.params.id
  const { contenido } = req.body

  try {
    // Actualizar el contenido del comentario en la base de datos
    await pool.query('UPDATE comentarios SET contenido = ? WHERE id = ?', [contenido, comentarioId])

    // Devolver mensaje de éxito
    res.json({ message: 'Comentario actualizado correctamente' })
  } catch (error) {
    // Manejar errores
    console.error('Error al actualizar el comentario:', error)
    res.status(500).json({ message: 'Error al actualizar el comentario' })
  }
})

// Ruta para eliminar un comentario existente
app.delete('/comentarios/:id', async (req, res) => {
  const comentarioId = req.params.id

  try {
    // Eliminar el comentario de la base de datos
    await pool.query('DELETE FROM comentarios WHERE id = ?', [comentarioId])

    // Devolver mensaje de éxito
    res.json({ message: 'Comentario eliminado correctamente' })
  } catch (error) {
    // Manejar errores
    console.error('Error al eliminar el comentario:', error)
    res.status(500).json({ message: 'Error al eliminar el comentario' })
  }
})

app.listen(PORT, () => { console.log('App running on port', PORT) })
