package com.carpe.system.support.hibernate;

import org.hibernate.Session;

import java.io.Serializable;

public abstract interface HibernateHandler extends Serializable {  
    public abstract Object doInHibernate(Session paramSession);  
}  