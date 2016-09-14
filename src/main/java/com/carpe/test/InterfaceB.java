package com.carpe.test;

import java.util.Iterator;

/**
 * Created by wrj on 2016-08-16
 */
public interface InterfaceB<E> extends  A<E> {

    E next();


    Iterator<E> iterator();
}

