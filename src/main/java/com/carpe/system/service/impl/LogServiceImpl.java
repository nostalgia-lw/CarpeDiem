package com.carpe.system.service.impl;

import com.carpe.system.dao.LogDao;
import com.carpe.system.entity.Log;
import com.carpe.system.service.LogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * LogServiceImpl
 *日志业务接口实现
 * @author wrj
 * @date 2016-07-07
 */
@Service
public class LogServiceImpl implements LogService {
     @Resource
    private LogDao logDao;

    @Override
    public void saveLog(Log log) {
        logDao.save(log);
    }
}
