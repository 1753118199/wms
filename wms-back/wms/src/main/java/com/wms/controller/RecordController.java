package com.wms.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.wms.common.QueryPageParam;
import com.wms.common.Result;
import com.wms.entity.Goods;
import com.wms.entity.Record;
import com.wms.entity.RecordSum;
import com.wms.service.GoodsService;
import com.wms.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 前端控制器
 * </p>
 */
@CrossOrigin
@RestController
@RequestMapping("/record")
public class RecordController {

    @Autowired
    private RecordService recordService;

    @Autowired
    private GoodsService goodsService;

    @PostMapping("/listPage")
    public Result listPage(@RequestBody QueryPageParam query) {
        HashMap param = query.getParam();
        String name = (String) param.get("name");
        String goodstype = (String) param.get("goodstype");
        String storage = (String) param.get("storage");
        String roleId = (String) param.get("roleId");
        String userId = (String) param.get("userId");

        Page<Record> page = new Page();
        page.setCurrent(query.getPageNum());
        page.setSize(query.getPageSize());

        QueryWrapper<Record> queryWrapper = new QueryWrapper();
        queryWrapper.apply(" a.goods=b.id and b.storage=c.id and b.goodsType=d.id ");

        if ("2".equals(roleId)) {
            // queryWrapper.eq(Record::getUserid,userId);
            queryWrapper.apply(" a.userId= " + userId);
        }

        if (StringUtils.isNotBlank(name) && !"null".equals(name)) {
            queryWrapper.like("b.name", name);
        }
        if (StringUtils.isNotBlank(goodstype) && !"null".equals(goodstype)) {
            queryWrapper.eq("d.id", goodstype);
        }
        if (StringUtils.isNotBlank(storage) && !"null".equals(storage)) {
            queryWrapper.eq("c.id", storage);
        }

        IPage result = recordService.pageCC(page, queryWrapper);
        return Result.suc(result.getRecords(), result.getTotal());
    }

    @GetMapping("/list")
    public Result list() {
        List<Record> list = recordService.list();
        Map<String, Object> map = new HashMap<>();
        String[] goods = new String[list.size()];
        int[] count = new int[list.size()];
        for (int i = 0; i < list.size(); i++) {
            goods[i] = goodsService.getById(list.get(i).getGoods()).getName();
            count[i] = list.get(i).getCount();
        }
        map.put("goods", goods);
        map.put("count", count);
        return Result.suc(map);
    }


    //新增
    @PostMapping("/save")
    public Result save(@RequestBody Record record) {
        Goods goods = goodsService.getById(record.getGoods());
        int n = record.getCount();
        //出库
        if ("2".equals(record.getAction())) {
            n = -n;
            record.setCount(n);
        }

        int num = goods.getCount() + n;
        goods.setCount(num);
        goodsService.updateById(goods);

        return recordService.save(record) ? Result.suc() : Result.fail();
    }

    @GetMapping("/outAndIn")
    public Result outAndIn() {
        List<RecordSum> inList = recordService.in();
        List<RecordSum> outList = recordService.out();
        Map<String, Object> map = new HashMap<>();
        map.put("inList", inList);
        map.put("outList", outList);
        return Result.suc(map);
    }

}
