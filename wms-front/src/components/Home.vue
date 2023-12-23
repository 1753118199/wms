<template>
  <div>
    <el-breadcrumb separator="/" style="margin-left: 20px; margin-top: 10px">
      <el-breadcrumb-item :to="{ path: '/Home' }">首页</el-breadcrumb-item>
    </el-breadcrumb>
    <div
      style="
        text-align: center;
        background-color: #f1f1f3;
        height: 100%;
        padding: 0px;
        margin: 20px;
      "
    >
      <h1 style="font-size: 50px">{{ "欢迎你！" + user.name }}</h1>
      <el-descriptions title="个人中心" :column="2" size="40" border>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-s-custom"></i>
            账号
          </template>
          {{ user.no }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-mobile-phone"></i>
            电话
          </template>
          {{ user.phone }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-location-outline"></i>
            性别
          </template>
          <el-tag :type="user.sex === '1' ? 'primary' : 'danger'" disable-transitions
            ><i :class="user.sex == 1 ? 'el-icon-male' : 'el-icon-female'"></i
            >{{ user.sex == 1 ? "男" : "女" }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-tickets"></i>
            角色
          </template>
          <el-tag type="success" disable-transitions
            >{{ user.roleId == 0 ? "超级管理员" : user.roleId == 1 ? "管理员" : "用户" }}
          </el-tag>
        </el-descriptions-item>
      </el-descriptions>

      <DateUtils></DateUtils>
    </div>
    <div class="echart1" id="echart1" ref="chart"></div>
  </div>
</template>

<script>
import DateUtils from "./DateUtils";

export default {
  name: "Home",
  components: { DateUtils },
  data() {
    return {
      responseData: {},
      user: {},
    };
  },

  methods: {
    async init() {
      this.user = JSON.parse(sessionStorage.getItem("CurUser"));
    },

    async getData() {
      try {
        const response = await this.$axios.get(this.$httpUrl + "/goods/list");
        if (response && response.data) {
          this.responseData = response.data.data;
          console.log(this.responseData);
          return true;
        }
      } catch (error) {
        console.error("Error fetching data:", error);
        return false;
      }
    },

    async initEchart() {
      try {
        await this.getData();
        if (this.responseData) {
          const option = {
            title: {
              text: "物品剩余量",
              top: "5%",
              left: "center",
            },
            xAxis: {
              type: "category",
              data: this.responseData.xData,
            },
            yAxis: {
              type: "value",
            },
            series: [
              {
                data: this.responseData.yData,
                type: "bar",
                showBackground: true,
                backgroundStyle: {
                  color: "rgba(180, 180, 180, 0.2)",
                },
                itemStyle: {
                  color: function (params) {
                    // 根据条件设置不同的颜色
                    if (params.value < 100) {
                      return "#ff7100"; // 小于50的数据
                    } else {
                      return "#73a0fa"; // 大于等于50的数据
                    }
                  },
                },
              },
            ],
            label: {
              show: true,
              position: "top",
              formatter: "{c}",
            },
          };
          const myChart = this.$echarts.init(document.getElementById("echart1"));
          this.draw(option, myChart);
        } else {
          console.error("Failed to fetch data for chart initialization.");
        }
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    },

    draw(option, myChart) {
      myChart.clear();
      myChart.setOption(option);
    },
  },

  mounted() {
    this.init();
    this.initEchart();
  },
};
</script>

<style scoped>
.el-descriptions {
  width: 90%;
  margin: 0 auto;
  text-align: center;
}
.echart1 {
  display: flex;
  justify-content: space-between;
  width: 100%;
  height: 300px;
}
</style>
