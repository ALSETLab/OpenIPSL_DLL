within TwoAreas.Data;


record PF4
  extends Support.PF_TwoAreas(
    voltages(
      V1=1.02999997139,
      A1=39.419670105,
      V2=1.04999995232,
      A2=22.7480773926,
      V3=1.02999997139,
      A3=-7.00000047684,
      V4=1.00999999046,
      A4=-17.5402793884,
      V5=1.0069,
      A5=13.7881,
      V6=0.97914,
      A6=3.7146,
      V7=1.01935839653,
      A7=6.56502771378,
      V8=0.94828,
      A8=-18.5131,
      V9=0.960842967033,
      A9=-31.4690284729,
      V10=0.98486,
      A10=-23.7131,
      V11=1.0088,
      A11=-13.4215),
    machines(
      P1_1=1100.0000,
      Q1_1=187.957901001,
      P2_1=700,
      Q2_1=260.817138672,
      P3_1=757.885437012,
      Q3_1=218.426849365,
      P4_1=300,
      Q4_1=112.58140564),
    loads(
      PL7_1=1166.999877934,
      QL7_1=-523.4548797604,
      PL9_1=1567.0,
      QL9_1=-223.1267089844));
  annotation (Documentation(info="<html>
<p>Not working</p>
</html>", revisions="<html>
<!--DISCLAIMER-->
<p>OpenIPSL:</p>
<p>Copyright 2016 SmarTS Lab (Sweden)</p>
<ul>
<li>SmarTS Lab, research group at KTH: <a href=\"https://www.kth.se/en\">https://www.kth.se/en</a></li>
</ul>
<p>The authors can be contacted by email: <a href=\"mailto:luigiv@kth.se\">luigiv@kth.se</a></p>

<p>This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. </p>
<p>If a copy of the MPL was not distributed with this file, You can obtain one at <a href=\"http://mozilla.org/MPL/2.0/\"> http://mozilla.org/MPL/2.0</a>.</p>

<p></p>
<p>iPSL:</p>
<p>Copyright 2015-2016 RTE (France), SmarTS Lab (Sweden), AIA (Spain) and DTU (Denmark)</p>
<ul>
<li>RTE: <a href=\"http://www.rte-france.com\">http://www.rte-france.com</a></li>
<li>SmarTS Lab, research group at KTH: <a href=\"https://www.kth.se/en\">https://www.kth.se/en</a></li>
<li>AIA: <a href=\"http://www.aia.es/en/energy\"> http://www.aia.es/en/energy</a></li>
<li>DTU: <a href=\"http://www.dtu.dk/english\"> http://www.dtu.dk/english</a></li>
</ul>
<p>The authors can be contacted by email: <a href=\"mailto:info@itesla-ipsl.org\">info@itesla-ipsl.org</a></p>

<p>This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. </p>
<p>If a copy of the MPL was not distributed with this file, You can obtain one at <a href=\"http://mozilla.org/MPL/2.0/\"> http://mozilla.org/MPL/2.0</a>.</p>
</html>
"));
end PF4;
