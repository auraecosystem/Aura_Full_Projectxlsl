import React from 'react'
import QRCode from 'qrcode.react'
import styled from 'styled-components'

const Container = styled.div`
  font-family: Arial, sans-serif;
  text-align: center;
  padding: 20px;
  max-width: 400px;
  margin: auto;
  border: 1px solid #ddd;
  border-radius: 10px;
`

const Title = styled.h2`
  margin-bottom: 10px;
`

const Address = styled.p`
  font-weight: bold;
  font-size: 14px;
  word-break: break-all;
  margin: 10px 0;
`

const PaymentWidget: React.FC = () => {
  // Your BTC address
  const btcAddress = '37Xa3AVY4xjVWVdK4sTkEHDXmpqfoUzA22'
  const paymentString = `bitcoin:${btcAddress}`

  return (
    <Container>
      <Title>Pay with Bitcoin</Title>
      <QRCode value={paymentString} size={200} />
      <Address>{btcAddress}</Address>
      <p style={{ fontSize: '12px', color: '#666' }}>
        Scan this QR code or copy the address to send BTC
      </p>
    </Container>
  )
}

export default PaymentWidget
