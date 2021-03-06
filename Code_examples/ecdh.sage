#!/usr/bin/env sage
"""Elliptic Curve Diffie-Hellman Key Exchange"""

import Crypto.Random.random
import hashlib

# In this exercise you will implement Diffie-Hellman key exchange
# over elliptic curves.

# Implement a Sage function that takes the curve parameters a, b, p, G,
# and n as inputs. E_p(a;b) defines an elliptic curve, G is the
# generator, and n is the order of G. Your function shall return a
# public and a private ECDH key.

def generateKey(a, b, p, G, n):

    e = EllipticCurve(IntegerModRing(p), [a,b])
    n_a = random_prime(n)
    p_a = e(G[0], G[1]) * n_a

    private = n_a
    public  = p_a

    return(public, private)


def computeSharedSecret(othersPublicKey, myPrivateKey):

    return othersPublicKey * myPrivateKey

# Simulate DH key exchange. In the following function, add code that
# calculates the shared keys of user A and of user B. The result
# of user A's shared key calculation shall be stored in variable
# sharedSecretCalculationA, and the value of user B's shared key
# calculation shall be stored in variable sharedSecretCalculationB.

def keyExchangeSimulation(a, b, p, G, n):
    (publicA, privateA) = generateKey(a, b, p, G, n)
    (publicB, privateB) = generateKey(a, b, p, G, n)

    sharedSecretCalculationA = computeSharedSecret(publicB, privateA)
    sharedSecretCalculationB = computeSharedSecret(publicA, privateB)

    assert(sharedSecretCalculationA == sharedSecretCalculationB)

def aliceAndBobExchangeKeys():
    # Alice and Bob use the ECDH key exchange technique with the
    # following parameters:
    a = 8
    b = 12
    p = 23
    n = 28
    G = (4, 19)

    e = EllipticCurve(IntegerModRing(p), [a,b])

    G = e(4, 19)

    print e
    print "G =", G
    print ""

    # If Alice's private key is 21, what is her public key?
    privateA = 21

    print "Alice' private key:", privateA

    publicA = G * privateA

    print "Alice' public key: ", publicA
    print ""

    # If Bob's private key is 11, what is his public key?
    privateB = 11

    print "Bobs private key:  ", privateB

    publicB = G * privateB

    print "Bobs public key:   ", publicB
    print ""

    # What is their shared secret?

    sharedSecretA = computeSharedSecret(publicB, privateA)

    print "Alice calculates: publicB*privateA =", sharedSecretA

    sharedSecretB = computeSharedSecret(publicA, privateB)

    print "Bob   calculates: publicA*privateB =", sharedSecretB

    assert(sharedSecretA == sharedSecretB)

if __name__ == "__main__":
    for _ in xrange(0x100):
        keyExchangeSimulation(a=1, b=1, p=23, G=(9, 7), n=28)
    aliceAndBobExchangeKeys()

