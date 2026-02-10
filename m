Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8ACEA3F3A
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 10:28:13 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16669.1770719292587570909
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Feb 2026 02:28:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hVPNgOEO;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.61, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOCH3u96j1FKeuEBjOVaMeNf6n58AnTMJ0fG4sT7pZ20swngwcyrpthCUYuBtERWUj+1zh1/atTU2cTytGtMiDSIU854D24NwF/H++YhiBT8wlGziz6jCaiIJ4PuWCa3xkoJdygzISnmgHLRXF4t6cWv8QkVxG5xnH7rc9SHHbVMjNNBfwOPXoCe4ClCGbvI6jfexeakwyNEBx7mdKBatbAqYHHrcXEy0MI7YNwO+ZCx0z4It/nj8u2jWHJW37DHmzhWLCZcCQGDzmii30M41EEBs0s7+j9qRuLqLvzM9Tcx/ft8wL73R57o6eZYPYXiZXyStLrSGaU3YsW081MQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxtnXpzOqs8sx61uv+1ar/VTWBvB1vAaE+w2qjskru8=;
 b=H83FwrCNVBUoUfqrVygdPRmb5VG1dwENLHSGkJEywxmBFJQpOVDvacL8gTLPsYpWjnV59w9P/3sNtWuwk7zmhPENmhqijF+iPWh5hk0QRVefbLxbyzp2VQGGNfYmpR0GrW6J+BeC5hkJ8zIr5Y+xWgu6AtywxbyklCS5ysm0jDRrg8+v5ZmMRy5p352iBseelXaRX5H3d/7EnP+oKjFedBiMXAn6tVGv68ByTqEa2aNa0sChsPpjM8PoGBzkC++Srjf/k14t4YMNu3HePg+Q2C1WvmPFrtlzBzMXjuZouv1yn4JWQZ8vGs3RbVq7COPeNPjExILwWiNW4Qg8gMs2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxtnXpzOqs8sx61uv+1ar/VTWBvB1vAaE+w2qjskru8=;
 b=hVPNgOEO6a7C+S4s3BQcba1hpFH7XtQT5AB6Zt5aBbC3T2NLB+GxBNWcxoaIbgPn0KKQQ6VsCognmBBka6LlnDOJpRja7tqzQ5XkiP+f3uLGsff7JrW2X+GOOGiW9rE9IEHxMC36OoxnCYT73RE1kJ61wTCgHl45+OCUH8ns8kQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10424.jpnprd01.prod.outlook.com (2603:1096:400:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 10:28:08 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 10:28:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip] i2c: riic: Move suspend handling to NOIRQ phase
Date: Tue, 10 Feb 2026 11:27:47 +0100
Message-ID: <20260210102747.484082-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB10424:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ae18a2-65e3-4ba8-f34d-08de688f155c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eOYPTbl9JDkvX9ZhJ1qHBd/XiOcbFZAuLNcygBx+5/AfBbjy1sri2oUlkzUb?=
 =?us-ascii?Q?10byG8S7AcOc98vThCWDI+LJEz2n2TE1uUMmMq/gnidXebri5tc8tJreMgXv?=
 =?us-ascii?Q?0i4SwEcT0jhDxJ1wEGjAPZNIUot7yJGawgdpH8hof+a4FYl0bIXgQE7YYKdO?=
 =?us-ascii?Q?q5uf2Jqub50tCahPcfFD/FfUdVtZ4Vgj6NHZnO9FqG50hDYNiJfCveXsbyAh?=
 =?us-ascii?Q?DMAFPWR55CGeuqMVgnLnT0TYjO4T+F8Pd2QI7ia6hnBZpCbz05LWX5xSMLmf?=
 =?us-ascii?Q?CPxeCQLtTfbFA6NKOwG7RhoRShuczxnaR81I6yZpm/AseYxBCB8QrDFFTVed?=
 =?us-ascii?Q?sRjq+KOCEJ2YjReCnR2I6NmAELPDbSnR8msGZ+nT/hjlmz3jobeY+k5wFhzR?=
 =?us-ascii?Q?yo32UbNr76IbJwdIAvyFs38kZb0vlNV/kNl1jmX6AL053sX999bXw+fKgJsr?=
 =?us-ascii?Q?3f0iCPRu99qTFkONxCS7QTMKJ1Y+yIYQAWe3Rcp7JNmFbgScLHic9gquvxt7?=
 =?us-ascii?Q?TRaeZglnY7I5tsGnWPZ2JSg6MpvgV89SphdRb6yRq2YhrCYavhVXIkFXNkt8?=
 =?us-ascii?Q?sYGHOVpNdcPpZwanwUQQxUGO6DXaHBsz93l1HaUnwC0MhmUQPP28+M5y6x0P?=
 =?us-ascii?Q?FGlgzH4ATlHGHnPusqXjUlu/vnlLjeanX21CHppG3M6Lb1FrRIOLXLufU6hf?=
 =?us-ascii?Q?uip2vFUHovXMQOquLJG2TADcuDfHfgsl4aOQZJZKvsihEZjJecqf6AeBiknV?=
 =?us-ascii?Q?hk7PUN0+kSjofDGfegNvLQvn5CExMZO8k4UROZKj4ciUhSLg8UDGWnMZIpbX?=
 =?us-ascii?Q?krYUkGxNjHjpWchz3H9/Q9ffWO3Da/Bt1dp3dlhx9jQUirBFMdboUrIAFJCT?=
 =?us-ascii?Q?jzWlTPYE2TUL5iOSOccVrJOIvFS1VexABMTmVID1dV04ZFg5fGfS/g1iSIlK?=
 =?us-ascii?Q?T7lzQob3P2VCrykNLmKMUstJr6s3SzyzdF3NN+nxXPcd2a0JC16CcvwZFpbH?=
 =?us-ascii?Q?qBPSKFo8f7NId+hsfXAQFItgRqZJjAYfC7j1EMzMIH1F+xf7xzXaD9qCYgrJ?=
 =?us-ascii?Q?7G1RmEpvAn361R+XUjsb9tso4ycR7+WExBZkPTeYyEjjv3xgq+VtbZAkuuvo?=
 =?us-ascii?Q?Q0YFuro5miLjkS4WU/R4HWwDEial+p/nM9CBHJxaX1hlZMXCIMHynaZykVAJ?=
 =?us-ascii?Q?EckoodzlyzMMwnr88lqC3UeXDyuH/q8JFt5/EuErYxoJEA1hmRYEmkH94JN7?=
 =?us-ascii?Q?cCMrTrQd1mPyFcF9ZdcXKVzKbLJzJpg9S9numjaThztMJotzIddj4EmikYox?=
 =?us-ascii?Q?GjAE9AkYWbeF1vH/B8sqvI0qLrbBB1EOI/BEnuwb9cLZ6Hrr1aS/cQtKp2qn?=
 =?us-ascii?Q?q665qnVRJqG4m1SOpH7MjDQlt4BkQkTKsioqEMz1foxFZuuC4KP8eBmd93Q4?=
 =?us-ascii?Q?lsxCkP3ZysnVgFBnn+/Aikw2Bgx1sLIv07WRs0jZ56FWeN7IFV+uSDSOkfZq?=
 =?us-ascii?Q?MrpVlun+YaWRJgZEqy+kXYN+IBBIvCANNYp/lAb/4q6+EUNHMv1h/3se9xhc?=
 =?us-ascii?Q?OmPEwx6SJ3AF2vjJ58wQOegR3W/1dlI/4wsqCF8oFhAXtvhZ5Py6KqjqkMIw?=
 =?us-ascii?Q?knQ3OdZaUaNY59cioEcd3EU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8/pdBPkYXcDKuP3Bwlrr9zcrdiFRYhtlOTgnH9UyzTvXWW7C4vpbM6i9AISr?=
 =?us-ascii?Q?L11AS9oyUUqruWnJsBqGho9eVlxh5pjQNodt2wR2IaNlVdADCiL2PzxrVxuP?=
 =?us-ascii?Q?CYAjoLNwxfviBzFc/JFZKMuCWtN+kTmutaBM6ztmGdkQKiXz+Ny03X7uMaS7?=
 =?us-ascii?Q?Oiy3BQXaHviax3Lu2UIcdPf+cxEN0jpUr9GtlsZFDy8v1RQN5iQO3IYZEm8p?=
 =?us-ascii?Q?MLiJpHcOU2ldZpgRvIpUoCxsr3hI0dlrLEkip3IEnXoM2edsjSwkKpTNVwf6?=
 =?us-ascii?Q?GyCMCnA1BA/msZUW02VK4XkMQfK1pG/AfUkOSW1HdlxRsDgRteKvEAnDwnn2?=
 =?us-ascii?Q?HdX8CR00Dv/K386OD6KkEp+Jwl9Jfy4qlKoT1nk9/WpOH73kWa9MlqFDetJm?=
 =?us-ascii?Q?8nX/CFEG6pfId2b62VbnizH+U4Vw3JQW8LhVeTC0FErn7A4zo5m8vjM5jkZG?=
 =?us-ascii?Q?L2C7Xl9T8JCQYjpWq2IggXJ6mlQXbYZUg3PMqtwDaf3s+S91gmyO+Cp8bc6Q?=
 =?us-ascii?Q?ekLh5F4jVUyChha9bCgnrK94O5ZTUaXeI5yqrRiQu5/9a6V6xcdVtAboC/J5?=
 =?us-ascii?Q?O5Qa7JiCJ14eeWonw7Bwi46UabMc2Wi2RxcLHvhyWOsJ9PbU4oCohso/h5IQ?=
 =?us-ascii?Q?gi3ZKp6IqP8ybgq20Xg4YSlPn9JwotxK3VT/WbwDrpFoUIR1peF6Ur5SiLZ9?=
 =?us-ascii?Q?utm9Snbw/5KbF6C16B7TLdPjEUiV4z6hUCSW0OkYyLVSwHx4uudjkH1baD9g?=
 =?us-ascii?Q?WbcMqTsn5n8LsXOtquLekSwxMevdmUWhhWkGR0hEKio4HeH9NVnrIjlP1jTB?=
 =?us-ascii?Q?GI+OSPh9V2FO8ijXM40qEhCiNg2mF/8O6gD55nOKzcuMLtgOiIJxHJrknyYA?=
 =?us-ascii?Q?tsZ3OTPtPic62yxXooIIOLbZ0tKR1GM7nXn7IQpOV/3LOJxv5voslo3/p6w/?=
 =?us-ascii?Q?sRmLUrvmeGbYpQzrwAR4bz3TEbjCyVM2hm+0fnoCa0n2KJcdQZawgNzslRcY?=
 =?us-ascii?Q?dZ11UwyHVGyPiaBN+vDJhPbeYX4V5LgGyR6g6ujAKigc1+bJwG2W9jNQ8S5q?=
 =?us-ascii?Q?8J2RyE5XF66/c2Ykxp75u74xlrsg0IrSneCA7aq2Bn3Fn+Osb0poPk+TlTPS?=
 =?us-ascii?Q?N9wfR6+1KmNQPlYgZKx6se/M+7+05K+FKZI8+lYIB0lV3osLzw8QyNJKAWx+?=
 =?us-ascii?Q?IG6hTDhoVAYdRRSzldmA1Hn4fqGhG6wzshBT8IUyxEnN3lU+/H7JcfSxzMFU?=
 =?us-ascii?Q?2nyIKHykO4zv1As3NVxCClmLtv6hqsPbEEHq8MJLHa0GVLXtL3lJcT3gKcL6?=
 =?us-ascii?Q?8/OM883/TTEQRDiRA4A1/AbKa3RxKHswe0/ZA9i2D5qrcLfYLAWGQOqcXjaS?=
 =?us-ascii?Q?L0OJ/OQaiv4RhwNIoOMnluisx3TnG2Z3GYu4th58DIgV6GMOCkGGPJnIfjAP?=
 =?us-ascii?Q?00Q+xD+3cqDuSmTie8E90k4LwNCoEbqDSzHwD2NaAx1w2xQpHlUGBSofWaO9?=
 =?us-ascii?Q?170LGUP2UYW/kAgperoKCw+trKffUSEwi/GAtTtkMNe3pK7uIOfY3DqnC+pd?=
 =?us-ascii?Q?2CaZmDAEehPqjPT3FBWm7GuljWbHsPTW5JJiRJnDMf6caDp9kT4V5+Hb4r93?=
 =?us-ascii?Q?SfALmd4UfNqTqE78U4PkBfOuhHRYPdP21iqsNaXpYv+CCRHLWRZTdlRdhnl1?=
 =?us-ascii?Q?EvhmJgocZKRD/osTEhMhc/OI3BhkzGo75fUH594xWzKxfmCADW0UkgGCkSF3?=
 =?us-ascii?Q?RLf2HPcjhec8jGAzuonns7LXxohBuchePrA722blv8SoaJdbS5Px?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ae18a2-65e3-4ba8-f34d-08de688f155c
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:28:08.4527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWakEJrPqVVcSZ3VVaQBbQhfEEJRlg9SQZPQa3nIhS6prFn8SGBv+4CoM/WmxaaHRyA4gTMLU7oP3ibiRmsuUUxSodPJfXOjNaqCcij+wNW6cElDPrONsEBwlOD70ZOI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10424
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Feb 2026 10:28:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21852

commit e383f0961422f983451ac4dd6aed1a3d3311f2be upstream.

Commit 53326135d0e0 ("i2c: riic: Add suspend/resume support") added
suspend support for the Renesas I2C driver and following this change
on RZ/G3E the following WARNING is seen on entering suspend ...

[  134.275704] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[  134.285536] ------------[ cut here ]------------
[  134.290298] i2c i2c-2: Transfer while suspended
[  134.295174] WARNING: drivers/i2c/i2c-core.h:56 at __i2c_smbus_xfer+0x1e4=
/0x214, CPU#0: systemd-sleep/388
[  134.365507] Tainted: [W]=3DWARN
[  134.368485] Hardware name: Renesas SMARC EVK version 2 based on r9a09g04=
7e57 (DT)
[  134.375961] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  134.382935] pc : __i2c_smbus_xfer+0x1e4/0x214
[  134.387329] lr : __i2c_smbus_xfer+0x1e4/0x214
[  134.391717] sp : ffff800083f23860
[  134.395040] x29: ffff800083f23860 x28: 0000000000000000 x27: ffff800082e=
d5d60
[  134.402226] x26: 0000001f4395fd74 x25: 0000000000000007 x24: 00000000000=
00001
[  134.409408] x23: 0000000000000000 x22: 000000000000006f x21: ffff800083f=
23936
[  134.416589] x20: ffff0000c090e140 x19: ffff0000c090e0d0 x18: 00000000000=
00006
[  134.423771] x17: 6f63657320313030 x16: 2e30206465737061 x15: ffff800083f=
23280
[  134.430953] x14: 0000000000000000 x13: ffff800082b16ce8 x12: 00000000000=
00f09
[  134.438134] x11: 0000000000000503 x10: ffff800082b6ece8 x9 : ffff800082b=
16ce8
[  134.445315] x8 : 00000000ffffefff x7 : ffff800082b6ece8 x6 : 80000000fff=
ff000
[  134.452495] x5 : 0000000000000504 x4 : 0000000000000000 x3 : 00000000000=
00000
[  134.459672] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c9e=
e9e80
[  134.466851] Call trace:
[  134.469311]  __i2c_smbus_xfer+0x1e4/0x214 (P)
[  134.473715]  i2c_smbus_xfer+0xbc/0x120
[  134.477507]  i2c_smbus_read_byte_data+0x4c/0x84
[  134.482077]  isl1208_i2c_read_time+0x44/0x178 [rtc_isl1208]
[  134.487703]  isl1208_rtc_read_time+0x14/0x20 [rtc_isl1208]
[  134.493226]  __rtc_read_time+0x44/0x88
[  134.497012]  rtc_read_time+0x3c/0x68
[  134.500622]  rtc_suspend+0x9c/0x170

The warning is triggered because I2C transfers can still be attempted
while the controller is already suspended, due to inappropriate ordering
of the system sleep callbacks.

If the controller is autosuspended, there is no way to wake it up once
runtime PM disabled (in suspend_late()). During system resume, the I2C
controller will be available only after runtime PM is re-enabled
(in resume_early()). However, this may be too late for some devices.

Wake up the controller in the suspend() callback while runtime PM is
still enabled. The I2C controller will remain available until the
suspend_noirq() callback (pm_runtime_force_suspend()) is called. During
resume, the I2C controller can be restored by the resume_noirq() callback
(pm_runtime_force_resume()). Finally, the resume() callback re-enables
autosuspend. As a result, the I2C controller can remain available until
the system enters suspend_noirq() and from resume_noirq().

Cc: stable@vger.kernel.org
Fixes: 53326135d0e0 ("i2c: riic: Add suspend/resume support")
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 46 +++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 26975f44c999..f1570872a63f 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -602,12 +602,39 @@ static const struct riic_of_data riic_rz_v2h_info =3D=
 {
=20
 static int riic_i2c_suspend(struct device *dev)
 {
-	struct riic_dev *riic =3D dev_get_drvdata(dev);
-	int ret;
+	/*
+	 * Some I2C devices may need the I2C controller to remain active
+	 * during resume_noirq() or suspend_noirq(). If the controller is
+	 * autosuspended, there is no way to wake it up once runtime PM is
+	 * disabled (in suspend_late()).
+	 *
+	 * During system resume, the I2C controller will be available only
+	 * after runtime PM is re-enabled (in resume_early()). However, this
+	 * may be too late for some devices.
+	 *
+	 * Wake up the controller in the suspend() callback while runtime PM
+	 * is still enabled. The I2C controller will remain available until
+	 * the suspend_noirq() callback (pm_runtime_force_suspend()) is
+	 * called. During resume, the I2C controller can be restored by the
+	 * resume_noirq() callback (pm_runtime_force_resume()).
+	 *
+	 * Finally, the resume() callback re-enables autosuspend, ensuring
+	 * the I2C controller remains available until the system enters
+	 * suspend_noirq() and from resume_noirq().
+	 */
+	return pm_runtime_resume_and_get(dev);
+}
=20
-	ret =3D pm_runtime_resume_and_get(dev);
-	if (ret)
-		return ret;
+static int riic_i2c_resume(struct device *dev)
+{
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static int riic_i2c_suspend_noirq(struct device *dev)
+{
+	struct riic_dev *riic =3D dev_get_drvdata(dev);
=20
 	i2c_mark_adapter_suspended(&riic->adapter);
=20
@@ -615,12 +642,12 @@ static int riic_i2c_suspend(struct device *dev)
 	riic_clear_set_bit(riic, ICCR1_ICE, 0, RIIC_ICCR1);
=20
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_sync(dev);
+	pm_runtime_force_suspend(dev);
=20
 	return reset_control_assert(riic->rstc);
 }
=20
-static int riic_i2c_resume(struct device *dev)
+static int riic_i2c_resume_noirq(struct device *dev)
 {
 	struct riic_dev *riic =3D dev_get_drvdata(dev);
 	int ret;
@@ -629,6 +656,10 @@ static int riic_i2c_resume(struct device *dev)
 	if (ret)
 		return ret;
=20
+	ret =3D pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
 	ret =3D riic_init_hw(riic);
 	if (ret) {
 		/*
@@ -646,6 +677,7 @@ static int riic_i2c_resume(struct device *dev)
 }
=20
 static const struct dev_pm_ops riic_i2c_pm_ops =3D {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(riic_i2c_suspend_noirq, riic_i2c_resume_noirq)
 	SYSTEM_SLEEP_PM_OPS(riic_i2c_suspend, riic_i2c_resume)
 };
=20
--=20
2.43.0


