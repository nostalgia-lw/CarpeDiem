package com.carpe.test;

import com.carpe.system.entity.User;

import java.util.Iterator;

/**
 * Created by wrj on 2016-08-16
 */
public class InterfaceTest implements InterfaceB<User>   {
    @Override
    public boolean isEmpty() {
        return false;
    }

    @Override
    public boolean hasNext() {
        return false;
    }

    @Override
    public User next() {
        return null;
    }

    @Override
    public Iterator<User> iterator() {
        return null;
    }
}
