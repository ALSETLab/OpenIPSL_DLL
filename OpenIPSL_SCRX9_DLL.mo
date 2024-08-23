within ;
package OpenIPSL_SCRX9_DLL
  class SCRX9_DLL
    extends ExternalObject;

    function constructor
      output SCRX9_DLL scrx9_dll;
      external "C" scrx9_dll = init_scrx_model() annotation (Library="SCRX9",LibraryDirectory="modelica://OpenIPSL/Resources/Library");
    end constructor;

    function destructor
      input SCRX9_DLL scrx9_dll;
      external "C" deinit_scrx_model(scrx9_dll) annotation (Library="SCRX9",LibraryDirectory="modelica://OpenIPSL/Resources/Library");
    end destructor;

    annotation (Icon(graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.None), Text(
            extent={{-100,46},{98,-102}},
            textColor={238,46,47},
            textString="Class
")}));
  end SCRX9_DLL;

  package Functions
      function update
        input SCRX9_DLL scrx9_dll;
        input Real t;
        input Real vref;
        input Real ec;
        input Real vs;
        input Real ifd;
        input Real vt;
        input Real vuel;
        input Real voel;
        external "C" update_scrx_input(scrx9_dll,t,vref,ec,vs,ifd,vt,vuel,voel) annotation (Library="SCRX9",LibraryDirectory="modelica://OpenIPSL/Resources/Library");
      end update;

      function model_output
        input SCRX9_DLL scrx9_dll;
        output Real out;
        external "C" out = model_calculate(scrx9_dll) annotation (Library="SCRX9",LibraryDirectory="modelica://OpenIPSL/Resources/Library");
      end model_output;

      function get_time
        output Real out;
        external"C" out = get_sim_time() annotation (Library="SCRX9",LibraryDirectory="modelica://OpenIPSL/Resources/Library");
      end get_time;

    function add_c
      input Real a;
      input Real b;
      output Real sum;
      external "C" sum = my_sum(a,b) annotation (Library="SCRX9",LibraryDirectory="modelica://OpenIPSL/Resources/Library");
    end add_c;
  end Functions;

  package Tests
    model SCRX_Original "SMIB system to test functionality of SCRX model"
      extends OpenIPSL.Tests.BaseClasses.SMIB;
      OpenIPSL.Electrical.Machines.PSSE.GENROU gENROU(
        Tpd0=5,
        Tppd0=0.07,
        Tpq0=0.9,
        Tppq0=0.09,
        D=0,
        Xd=1.84,
        Xq=1.75,
        Xpd=0.41,
        Xpq=0.6,
        Xppd=0.2,
        Xl=0.12,
        S10=0.11,
        S12=0.39,
        angle_0=0.070492225331847,
        Xppq=0.2,
        R_a=0,
        Xpp=0.2,
        H=4.28,
        M_b=100000000,
        P_0=40000000,
        Q_0=5416582,
        v_0=1) annotation (Placement(transformation(extent={{-350,0},{-126,76}})));
      Modelica.Blocks.Sources.Constant zero(k=0) annotation (Placement(transformation(extent={{6,-6},{-6,6}}, origin={16,-114})));
      OpenIPSL.Electrical.Controls.PSSE.ES.SCRX sCRX(
        T_AT_B=0.1,
        T_B=1,
        K=100,
        E_MIN=-10,
        E_MAX=10,
        C_SWITCH=true,
        r_cr_fd=0,
        T_E=0.005)
        annotation (Placement(transformation(extent={{-76,-158},{-196,-38}})));
    equation
      connect(gENROU.PMECH, gENROU.PMECH0) annotation (Line(points={{-372.4,60.8},{
              -274,60.8},{-274,90},{-66,90},{-66,57},{-114.8,57}},
                                                         color={0,0,127}));
      connect(sCRX.EFD, gENROU.EFD) annotation (Line(points={{-202,-98},{-334,-98},
              {-334,15.2},{-372.4,15.2}},       color={0,0,127}));
      connect(gENROU.ETERM, sCRX.ECOMP) annotation (Line(points={{-114.8,26.6},{-48,
              26.6},{-48,-98},{-70,-98}},    color={0,0,127}));
      connect(sCRX.XADIFD, gENROU.XADIFD) annotation (Line(points={{-184,-164},{
              -184,-194},{-60,-194},{-60,3.8},{-114.8,3.8}},
                                                    color={0,0,127}));
      connect(sCRX.EFD0, gENROU.EFD0) annotation (Line(points={{-70,-122},{-54,-122},
              {-54,19},{-114.8,19}},          color={0,0,127}));
      connect(gENROU.p, GEN1.p)
        annotation (Line(points={{-126,38},{-44,38},{-44,0},{-30,0}},
                                                   color={0,0,255}));
      connect(sCRX.VOTHSG, zero.y) annotation (Line(points={{-70,-74},{-16,-74},{
              -16,-114},{9.4,-114}},                                                                    color={0,0,127}));
      connect(sCRX.VUEL, zero.y) annotation (Line(points={{-112,-164},{-112,-178},{
              0,-178},{0,-114},{9.4,-114}},                                                 color={0,0,127}));
      connect(sCRX.VOEL, zero.y) annotation (Line(points={{-136,-164},{-136,-186},{
              0,-186},{0,-114},{9.4,-114}},                                                 color={0,0,127}));
      annotation (
        experiment(
          StopTime=10,
          __Dymola_fixedstepsize=0.005,
          __Dymola_Algorithm="Euler"));
    end SCRX_Original;

    model test
      extends OpenIPSL.Tests.BaseClasses.SMIB(pwFault(t1=2, t2=2.15));
      OpenIPSL.Electrical.Branches.PwLine pwLine(
        R=0.001,
        X=0.2,
        G=0,
        B=0) annotation (Placement(transformation(extent={{-20,-4},{-8,4}})));
      OpenIPSL.Electrical.Branches.PwLine pwLine3(
        R=0.0005,
        X=0.1,
        G=0,
        B=0) annotation (Placement(transformation(extent={{14,-34},{26,-26}})));
      OpenIPSL.Electrical.Branches.PwLine pwLine4(
        R=0.0005,
        X=0.1,
        G=0,
        B=0) annotation (Placement(transformation(extent={{54,-34},{66,-26}})));
      OpenIPSL.Electrical.Machines.PSSE.GENCLS gENCLS(
        M_b=100e6,
        D=0,
        angle_0=0,
        X_d=0.2,
        H=0,
        P_0=10017110,
        Q_0=8006544,
        v_0=1) annotation (Placement(transformation(extent={{100,-10},{90,10}})));
      OpenIPSL.Electrical.Loads.PSSE.Load_variation constantLoad(
        PQBRAK=0.7,
        d_t=0,
        d_P=0,
        angle_0=-0.5762684,
        t1=0,
        characteristic=2,
        P_0=50000000,
        Q_0=10000000,
        v_0=0.9919935) annotation (Placement(transformation(extent={{-10,-72},{10,-52}})));
      OpenIPSL.Electrical.Events.PwFault pwFault(
        t1=2,
        t2=2.15,
        R=C.eps,
        X=C.eps)
             annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={40,-60})));
      OpenIPSL.Electrical.Buses.Bus GEN1
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      inner OpenIPSL.Electrical.SystemBase SysData(S_b=100e6, fn=50)
        annotation (Placement(transformation(extent={{-100,80},{-60,100}})));
      OpenIPSL.Electrical.Buses.Bus LOAD(v_0=constantLoad.v_0, angle_0=constantLoad.angle_0)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      OpenIPSL.Electrical.Buses.Bus GEN2
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
      OpenIPSL.Electrical.Buses.Bus FAULT
        annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
      OpenIPSL.Electrical.Branches.PwLine
                                 pwLine1(
        R=0.0005,
        G=0,
        B=0,
        X=0.1) annotation (Placement(transformation(extent={{14,26},{26,34}})));
      OpenIPSL.Electrical.Branches.PwLine
                                 pwLine2(
        R=0.0005,
        G=0,
        B=0,
        X=0.1) annotation (Placement(transformation(extent={{54,26},{66,34}})));
      OpenIPSL.Electrical.Buses.Bus
                           SHUNT
        annotation (Placement(transformation(extent={{30,20},{50,40}})));
      OpenIPSL.Electrical.Machines.PSSE.GENROU gENROU(
        Tpd0=5,
        Tppd0=0.07,
        Tpq0=0.9,
        Tppq0=0.09,
        D=0,
        Xd=1.84,
        Xq=1.75,
        Xpd=0.41,
        Xpq=0.6,
        Xppd=0.2,
        Xl=0.12,
        S10=0.11,
        S12=0.39,
        angle_0=0.070492225331847,
        Xppq=0.2,
        R_a=0,
        Xpp=0.2,
        H=4.28,
        M_b=100000000,
        P_0=40000000,
        Q_0=5416582,
        v_0=1) annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
      Blocks.SCRX sCRX
        annotation (Placement(transformation(extent={{-84,-40},{-60,-16}})));
    equation

      connect(GEN1.p,pwLine. p)
        annotation (Line(points={{-30,0},{-19.4,0}}, color={0,0,255}));
      connect(pwLine.n,LOAD. p)
        annotation (Line(points={{-8.6,0},{0,0}}, color={0,0,255}));
      connect(pwLine3.p,LOAD. p) annotation (Line(points={{14.6,-30},{10,-30},{10,0},
              {0,0}},color={0,0,255}));
      connect(constantLoad.p,LOAD. p)
        annotation (Line(points={{0,-52},{0,0}}, color={0,0,255}));
      connect(GEN2.p,gENCLS. p)
        annotation (Line(points={{80,0},{90,0}}, color={0,0,255}));
      connect(pwLine4.n,GEN2. p) annotation (Line(points={{65.4,-30},{70,-30},{70,0},
              {80,0}}, color={0,0,255}));
      connect(FAULT.p,pwLine4. p)
        annotation (Line(points={{40,-30},{54.6,-30}}, color={0,0,255}));
      connect(FAULT.p,pwLine3. n)
        annotation (Line(points={{40,-30},{25.4,-30}}, color={0,0,255}));
      connect(pwFault.p,pwLine4. p)
        annotation (Line(points={{40,-48.3333},{40,-30},{54.6,-30}},
                                                                color={0,0,255}));
      connect(pwLine1.p,LOAD. p)
        annotation (Line(points={{14.6,30},{10,30},{10,0},{0,0}},
                                                                color={0,0,255}));
      connect(pwLine1.n,SHUNT. p)
        annotation (Line(points={{25.4,30},{40,30}}, color={0,0,255}));
      connect(pwLine2.p,SHUNT. p)
        annotation (Line(points={{54.6,30},{40,30}}, color={0,0,255}));
      connect(pwLine2.n,GEN2. p) annotation (Line(points={{65.4,30},{70,30},{70,0},{
              80,0}},  color={0,0,255}));
      connect(gENROU.PMECH,gENROU. PMECH0) annotation (Line(points={{-84,6},{-94,
              6},{-94,26},{-54,26},{-54,5},{-61,5}},     color={0,0,127}));
      connect(gENROU.p,GEN1. p)
        annotation (Line(points={{-62,0},{-30,0}}, color={0,0,255}));

      connect(sCRX.XADIFD, gENROU.XADIFD) annotation (Line(points={{-60,-34},{
              -42,-34},{-42,-9},{-61,-9}}, color={0,0,127}));
      connect(sCRX.ETERM, gENROU.ETERM) annotation (Line(points={{-60,-22},{-36,
              -22},{-36,-3},{-61,-3}}, color={0,0,127}));
      connect(sCRX.EFD, gENROU.EFD) annotation (Line(points={{-85.2,-28},{-94,
              -28},{-94,-6},{-84,-6}}, color={0,0,127}));
     annotation (experiment(
          StopTime=10,
          Interval=0.005,
          Tolerance=1e-09,
          __Dymola_fixedstepsize=0.005,
          __Dymola_Algorithm="Euler"));
    end test;

    model test_fmu
      extends OpenIPSL.Tests.BaseClasses.SMIB(pwFault(t1=2, t2=2.15));
      OpenIPSL.Electrical.Branches.PwLine pwLine(
        R=0.001,
        X=0.2,
        G=0,
        B=0) annotation (Placement(transformation(extent={{-20,-4},{-8,4}})));
      OpenIPSL.Electrical.Branches.PwLine pwLine3(
        R=0.0005,
        X=0.1,
        G=0,
        B=0) annotation (Placement(transformation(extent={{14,-34},{26,-26}})));
      OpenIPSL.Electrical.Branches.PwLine pwLine4(
        R=0.0005,
        X=0.1,
        G=0,
        B=0) annotation (Placement(transformation(extent={{54,-34},{66,-26}})));
      OpenIPSL.Electrical.Machines.PSSE.GENCLS gENCLS(
        M_b=100e6,
        D=0,
        angle_0=0,
        X_d=0.2,
        H=0,
        P_0=10017110,
        Q_0=8006544,
        v_0=1) annotation (Placement(transformation(extent={{100,-10},{90,10}})));
      OpenIPSL.Electrical.Loads.PSSE.Load_variation constantLoad(
        PQBRAK=0.7,
        d_t=0,
        d_P=0,
        angle_0=-0.5762684,
        t1=0,
        characteristic=2,
        P_0=50000000,
        Q_0=10000000,
        v_0=0.9919935) annotation (Placement(transformation(extent={{-10,-72},{10,-52}})));
      OpenIPSL.Electrical.Events.PwFault pwFault(
        t1=2,
        t2=2.15,
        R=C.eps,
        X=C.eps)
             annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={40,-60})));
      OpenIPSL.Electrical.Buses.Bus GEN1
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      inner OpenIPSL.Electrical.SystemBase SysData(S_b=100e6, fn=50)
        annotation (Placement(transformation(extent={{-100,80},{-60,100}})));
      OpenIPSL.Electrical.Buses.Bus LOAD(v_0=constantLoad.v_0, angle_0=constantLoad.angle_0)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      OpenIPSL.Electrical.Buses.Bus GEN2
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
      OpenIPSL.Electrical.Buses.Bus FAULT
        annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
      OpenIPSL.Electrical.Branches.PwLine
                                 pwLine1(
        R=0.0005,
        G=0,
        B=0,
        X=0.1) annotation (Placement(transformation(extent={{14,26},{26,34}})));
      OpenIPSL.Electrical.Branches.PwLine
                                 pwLine2(
        R=0.0005,
        G=0,
        B=0,
        X=0.1) annotation (Placement(transformation(extent={{54,26},{66,34}})));
      OpenIPSL.Electrical.Buses.Bus
                           SHUNT
        annotation (Placement(transformation(extent={{30,20},{50,40}})));
      OpenIPSL.Electrical.Machines.PSSE.GENROU gENROU(
        Tpd0=5,
        Tppd0=0.07,
        Tpq0=0.9,
        Tppq0=0.09,
        D=0,
        Xd=1.84,
        Xq=1.75,
        Xpd=0.41,
        Xpq=0.6,
        Xppd=0.2,
        Xl=0.12,
        S10=0.11,
        S12=0.39,
        angle_0=0.070492225331847,
        Xppq=0.2,
        R_a=0,
        Xpp=0.2,
        H=4.28,
        M_b=100000000,
        P_0=40000000,
        Q_0=5416582,
        v_0=1) annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
      OpenIPSL_0SCRX9_0DLL_Blocks_SCRX_fmu
                  openIPSL_0SCRX9_0DLL_Blocks_SCRX_fmu
        annotation (Placement(transformation(extent={{-12,-12},{12,12}},
            rotation=180,
            origin={-72,-28})));
    equation

      connect(GEN1.p,pwLine. p)
        annotation (Line(points={{-30,0},{-19.4,0}}, color={0,0,255}));
      connect(pwLine.n,LOAD. p)
        annotation (Line(points={{-8.6,0},{0,0}}, color={0,0,255}));
      connect(pwLine3.p,LOAD. p) annotation (Line(points={{14.6,-30},{10,-30},{10,0},
              {0,0}},color={0,0,255}));
      connect(constantLoad.p,LOAD. p)
        annotation (Line(points={{0,-52},{0,0}}, color={0,0,255}));
      connect(GEN2.p,gENCLS. p)
        annotation (Line(points={{80,0},{90,0}}, color={0,0,255}));
      connect(pwLine4.n,GEN2. p) annotation (Line(points={{65.4,-30},{70,-30},{70,0},
              {80,0}}, color={0,0,255}));
      connect(FAULT.p,pwLine4. p)
        annotation (Line(points={{40,-30},{54.6,-30}}, color={0,0,255}));
      connect(FAULT.p,pwLine3. n)
        annotation (Line(points={{40,-30},{25.4,-30}}, color={0,0,255}));
      connect(pwFault.p,pwLine4. p)
        annotation (Line(points={{40,-48.3333},{40,-30},{54.6,-30}},
                                                                color={0,0,255}));
      connect(pwLine1.p,LOAD. p)
        annotation (Line(points={{14.6,30},{10,30},{10,0},{0,0}},
                                                                color={0,0,255}));
      connect(pwLine1.n,SHUNT. p)
        annotation (Line(points={{25.4,30},{40,30}}, color={0,0,255}));
      connect(pwLine2.p,SHUNT. p)
        annotation (Line(points={{54.6,30},{40,30}}, color={0,0,255}));
      connect(pwLine2.n,GEN2. p) annotation (Line(points={{65.4,30},{70,30},{70,0},{
              80,0}},  color={0,0,255}));
      connect(gENROU.PMECH,gENROU. PMECH0) annotation (Line(points={{-84,6},{-94,
              6},{-94,26},{-54,26},{-54,5},{-61,5}},     color={0,0,127}));
      connect(gENROU.p,GEN1. p)
        annotation (Line(points={{-62,0},{-30,0}}, color={0,0,255}));

      connect(openIPSL_0SCRX9_0DLL_Blocks_SCRX_fmu.XADIFD, gENROU.XADIFD)
        annotation (Line(points={{-59.52,-24.04},{-42,-24.04},{-42,-9},{-61,-9}},
            color={0,0,127}));
      connect(openIPSL_0SCRX9_0DLL_Blocks_SCRX_fmu.ETERM, gENROU.ETERM)
        annotation (Line(points={{-59.52,-32.08},{-36,-32.08},{-36,-3},{-61,-3}},
            color={0,0,127}));
      connect(openIPSL_0SCRX9_0DLL_Blocks_SCRX_fmu.EFD, gENROU.EFD) annotation
        (Line(points={{-86.4,-28},{-94,-28},{-94,-6},{-84,-6}}, color={0,0,127}));
     annotation (experiment(
          StopTime=10,
          Interval=0.005,
          Tolerance=1e-09,
          __Dymola_fixedstepsize=0.005,
          __Dymola_Algorithm="Euler"));
    end test_fmu;
  end Tests;

  package Blocks
    model SCRX
      Modelica.Blocks.Interfaces.RealInput ETERM(start = 1) annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={100,50})));
      Modelica.Blocks.Interfaces.RealInput XADIFD(start = 1.325) annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={100,-50})));
      Modelica.Blocks.Interfaces.RealOutput EFD annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-110,0})));
      SCRX9_DLL scrx9_struct = SCRX9_DLL();
    algorithm
        Functions.update(
          scrx9_struct,
          time,
          1,
          ETERM,
          0,
          XADIFD,
          ETERM,
          0,
          0);
      EFD:=Functions.model_output(scrx9_struct);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.None), Text(
              extent={{-78,48},{68,-48}},
              textColor={0,0,0},
              textString="SCRX9")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end SCRX;
  end Blocks;
  annotation (uses(OpenIPSL(version="3.1.0-dev"), Modelica(version="4.0.0")));
end OpenIPSL_SCRX9_DLL;
