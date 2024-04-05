import { pool } from './config/db.js'

export const admin = async (userEmail, userPassword, res) => {
  const [user] = await pool.query('SELECT * FROM usuarios WHERE email = ? AND password = ?', [userEmail, userPassword])

  if (user.length === 0) {
    throw new Error('Usuario incorrecto')
  }

  console.log(user[0].rol_id)
  if (user[0].rol_id !== 1) {
    return false
  }

  return true
}
