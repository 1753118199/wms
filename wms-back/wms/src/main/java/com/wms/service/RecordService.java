package com.wms.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.wms.entity.Record;
import com.baomidou.mybatisplus.extension.service.IService;
import com.wms.entity.RecordSum;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 */
public interface RecordService extends IService<Record> {

    IPage pageCC(IPage<Record> page, Wrapper wrapper);

    List<Record> list();

    List<RecordSum> in();

    List<RecordSum> out();
}
