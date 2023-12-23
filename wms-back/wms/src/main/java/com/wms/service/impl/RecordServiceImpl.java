package com.wms.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.wms.entity.Record;
import com.wms.entity.RecordSum;
import com.wms.mapper.RecordMapper;
import com.wms.service.RecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 */
@Service
public class RecordServiceImpl extends ServiceImpl<RecordMapper, Record> implements RecordService {

    @Resource
    private RecordMapper recordMapper;

    @Override
    public IPage pageCC(IPage<Record> page, Wrapper wrapper) {
        return recordMapper.pageCC(page, wrapper);
    }

    @Override
    public List<Record> list() {
        return recordMapper.list();
    }

    @Override
    public List<RecordSum> in() {
        return recordMapper.in();
    }

    @Override
    public List<RecordSum> out() {
        return recordMapper.out();
    }
}
