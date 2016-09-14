package com.carpe.test;

import java.util.Iterator;

/**
 * Created by wrj on 2016-08-16
 */
public interface A<E> {
    boolean isEmpty();

    boolean hasNext();

    E next();

    Iterator<E> iterator();
}

