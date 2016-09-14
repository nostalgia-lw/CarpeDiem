package com.carpe.test;

import java.util.Iterator;

/**
 * Created by wrj on 2016-08-16
 */
public abstract class AbstactC<E> implements   InterfaceB<E>,A<E> {

    public E next() {
        return null;
    }
    public Iterator<E> iterator() {
        return null;
    }
     abstract int  size();
}

