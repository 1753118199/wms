<template>
  <div>
    <el-breadcrumb
      separator="/"
      style="margin-left: 20px; margin-top: 10px; margin-bottom: 20px"
    >
      <el-breadcrumb-item :to="{ path: '/Home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>数据分析</el-breadcrumb-item>
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
      <div class="container1">
        <div class="echart1" id="echart1" ref="chart1" style="margin-left: 100px"></div>
        <div class="echart2" id="echart2" ref="chart2" style="margin-right: 200px"></div>
      </div>
      <div class="container2">
        <div class="echart3" id="echart3" ref="chart3" style="margin-left: 100px"></div>
        <div class="echart4" id="echart4" ref="chart4" style="margin-right: 200px"></div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Analysis",
  data() {
    return {
      date: [],
      in: [],
      out: [],
      responseData1: {},
      responseData2: {},
      responseData3: {},
      responseData4: {},
    };
  },

  mounted() {
    this.getData1();
    this.initEchart1();
    this.initEchart2();
    this.initEchart3();
    this.initEchart4();
  },

  methods: {
    draw(option, myChart) {
      myChart.clear();
      myChart.setOption(option);
    },

    async handleData1() {
      const data = this.responseData1;
      const dateMap = {}; // 使用对象存储日期和对应的正值和、负值和

      // 遍历 inList，将正值的 count 累加到对应日期的正值和中
      data.inList.forEach((item) => {
        const { date, count } = item;
        if (!dateMap[date]) {
          dateMap[date] = {
            date,
            positiveSum: count,
            negativeSum: 0,
          };
        } else {
          dateMap[date].positiveSum += count;
        }
      });

      // 遍历 outList，将负值的 count 累加到对应日期的负值和中
      data.outList.forEach((item) => {
        const { date, count } = item;
        if (!dateMap[date]) {
          dateMap[date] = {
            date,
            positiveSum: 0,
            negativeSum: count,
          };
        } else {
          dateMap[date].negativeSum += count;
        }
      });

      // 获取日期范围
      const currentDate = new Date();
      currentDate.setDate(currentDate.getDate() - 6); // 获取当前日期的前6天
      const endDate = new Date(); // 当前日期

      const dates = [];
      const positiveSums = [];
      const negativeSums = [];

      while (currentDate <= endDate) {
        const dateString = currentDate.toISOString().split("T")[0]; // 将日期转为字符串格式
        dates.push(dateString);
        if (dateMap[dateString]) {
          positiveSums.push(dateMap[dateString].positiveSum);
          negativeSums.push(dateMap[dateString].negativeSum);
        } else {
          positiveSums.push(0);
          negativeSums.push(0);
        }
        currentDate.setDate(currentDate.getDate() + 1); // 日期加1天
      }

      this.date = dates;
      this.in = positiveSums;
      this.out = negativeSums;
      console.log(dates);
      console.log(positiveSums);
      console.log(negativeSums);
    },

    async getData1() {
      try {
        const response = await this.$axios.get(this.$httpUrl + "/record/outAndIn");
        if (response && response.data) {
          this.responseData1 = response.data.data;
          console.log(this.responseData1);
          this.handleData1();
          return true;
        }
      } catch (error) {
        console.error("Error fetching data:", error);
        return false;
      }
    },

    async getData2() {
      try {
        const response = await this.$axios.get(this.$httpUrl + "/user/listAll");
        if (response && response.data) {
          this.responseData2 = response.data.data;
          console.log(this.responseData2);
          return true;
        }
      } catch (error) {
        console.error("Error fetching data:", error);
        return false;
      }
    },

    async getData3() {
      try {
        const response = await this.$axios.get(this.$httpUrl + "/record/list");
        if (response && response.data) {
          this.responseData3 = response.data.data;
          console.log(this.responseData3);
          return true;
        }
      } catch (error) {
        console.error("Error fetching data:", error);
        return false;
      }
    },

    async getData4() {
      try {
        const response = await this.$axios.get(this.$httpUrl + "/goods/list");
        if (response && response.data) {
          this.responseData4 = response.data.data;
          console.log(this.responseData4);
          return true;
        }
      } catch (error) {
        console.error("Error fetching data:", error);
        return false;
      }
    },

    async initEchart1() {
      try {
        await this.getData1();
        if (this.date && this.in && this.out) {
          const option = {
            title: {
              text: "一周内出入库总数折线图",
              top: "5%",
              left: "center",
            },
            tooltip: {
              trigger: "axis",
            },
            legend: {
              data: ["出库", "入库"],
            },
            grid: {
              left: "3%",
              right: "4%",
              bottom: "3%",
              containLabel: true,
            },
            toolbox: {
              feature: {
                saveAsImage: {},
              },
            },
            xAxis: {
              type: "category",
              boundaryGap: false,
              data: this.date,
            },
            yAxis: {
              type: "value",
            },
            series: [
              {
                name: "出库",
                type: "line",
                stack: "Total",
                data: this.out,
              },
              {
                name: "入库",
                type: "line",
                stack: "Total",
                data: this.in,
              },
            ],
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

    async initEchart2() {
      try {
        await this.getData2();
        if (this.responseData2) {
          const option = {
            title: {
              text: "系统用户分布饼图",
              subtext: "Fake Data",
              left: "center",
            },
            tooltip: {
              trigger: "item",
            },
            legend: {
              orient: "vertical",
              left: "left",
            },
            series: [
              {
                name: "用户类型",
                type: "pie",
                radius: "50%",
                data: [
                  { value: this.responseData2.root, name: "超级管理员" },
                  { value: this.responseData2.admin, name: "普通管理员" },
                  { value: this.responseData2.user, name: "普通用户" },
                ],
                emphasis: {
                  itemStyle: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: "rgba(0, 0, 0, 0.5)",
                  },
                },
              },
            ],
          };
          const myChart = this.$echarts.init(document.getElementById("echart2"));
          this.draw(option, myChart);
        } else {
          console.error("Failed to fetch data for chart initialization.");
        }
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    },

    async initEchart3() {
      try {
        await this.getData3();
        if (this.responseData3) {
          const option = {
            title: {
              text: "物品出入库记录",
              top: "5%",
              left: "center",
            },
            tooltip: {
              trigger: "axis",
              axisPointer: {
                type: "shadow",
              },
            },
            grid: {
              top: 80,
              bottom: 30,
            },
            xAxis: {
              type: "value",
              position: "top",
              splitLine: {
                lineStyle: {
                  type: "dashed",
                },
              },
            },
            yAxis: {
              type: "category",
              axisLine: { show: false },
              axisLabel: { show: false },
              axisTick: { show: false },
              splitLine: { show: false },
              data: this.responseData3.goods,
            },
            series: [
              {
                name: "Count",
                type: "bar",
                stack: "Total",
                label: {
                  show: false,
                  // formatter: function (params) {
                  //   if (params.value < 0) {
                  //     return params.name + " " + params.value;
                  //   } else {
                  //     return params.value + " " + params.name;
                  //   }
                  // },
                  // position: "left",
                },
                data: this.responseData3.count.map(function (value) {
                  return {
                    value: value,
                    // label: {
                    //   show: value < 0,
                    //   position: "right",
                    // },
                  };
                }),
              },
            ],
          };
          const myChart = this.$echarts.init(document.getElementById("echart3"));
          this.draw(option, myChart);
        } else {
          console.error("Failed to fetch data for chart initialization.");
        }
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    },

    async initEchart4() {
      try {
        await this.getData4();
        if (this.responseData4) {
          const option = {
            title: {
              text: "物品剩余量",
              top: "5%",
              left: "center",
            },
            xAxis: {
              type: "category",
              data: this.responseData4.xData,
            },
            yAxis: {
              type: "value",
            },
            tooltip: {
              trigger: "axis",
              axisPointer: {
                type: "shadow",
              },
              formatter: function (params) {
                const xValue = params[0].axisValue;
                const yValue = params[0].data;
                return `物品名：${xValue}<br/>剩余量：${yValue}`;
              },
            },
            series: [
              {
                data: this.responseData4.yData,
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
          const myChart = this.$echarts.init(document.getElementById("echart4"));
          this.draw(option, myChart);
        } else {
          console.error("Failed to fetch data for chart initialization.");
        }
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    },
  },
};
</script>

<style scoped>
.container1 {
  display: flex;
  justify-content: space-between;
}
.container2 {
  display: flex;
  justify-content: space-between;
}
.echart1 {
  width: 360px;
  height: 300px;
}
.echart2 {
  width: 360px;
  height: 300px;
}
.echart3 {
  width: 360px;
  height: 300px;
}
.echart4 {
  width: 360px;
  height: 300px;
}
</style>
