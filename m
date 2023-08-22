Return-Path: <tho1.nguyendat@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E857EE49A5
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 06:54:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.2886.1692687270954203781
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 23:54:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: tho1.nguyendat@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 37M6sTMR3159271; Tue, 22 Aug 2023 15:54:29 +0900
X-Iguazu-Qid: 2yAbS7mhe9sInqfx39
X-Iguazu-QSIG: v=2; s=0; t=1692687268; q=2yAbS7mhe9sInqfx39; m=Tj/XVnBRfT4LikfFLLC5n9PR24p780tTooW3RD04LRs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 37M6sRDD2220477
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 22 Aug 2023 15:54:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK4P2Scxto7Umj5Oq3a4P5zEhM5fxOkgCzk0Q3CaaUCV8Va38LrFxCDoGEEViNCAhEEtqbi/L2p0mNwAxsH07ZnTjefmoxWwNPUO8qxSwzMNjSPocUMOVjRgH4CaCO4e5Pbz5Cb6jwinidFmxrjmV8bz5ZoGzWIk4dPAJC/Qha+aHdj4ugu0M6YvyVRLexuUGB8afcQVpFKjXLmQ+aNhOg4De9A7nSd15gyTJYqLaPWUR7WJ6TZLFL/LCVLJHeNsIHBnuyiGslQ50PNz/hN7Qqrj/v+nlh0zFhvrEVqpvD42ICqcuMvm2riJ0Hia1RWPiPumv2FQUkMLZxSOrGXT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwqHaHuLulkC0lNzTyKD6X4iTSglim1mCQT9RnBDF08=;
 b=mG2zC3WQM0WpjE0L6Kp+9rAPtbXHRxzSL1tl5Pg5rL6ale82oB46jYT9KuZKIHCDuNXxQss5HqH6z0sQoxTPHk/vZc4uYJArTXpa58JCXt4E9yYxyKkQDpTSfnLcFavK6enYukfhfz5rjFDhG2WnSY5r/CAi7SFwfEwx6dROmf6emE2c8DMsvRY++Q2mHczohTebt6KIpcMQK6/zV4Te3pJxDqotFOlbxxcunZ4NSwc+wvd5iU+A4gWtM/+azIQNKzoVx90SIK8g3TjqF+65fNY/UjeNHR/4CQ1xnQOCdsTmFhZRYPhKjEEW859H7iplNDLVYFaFToZimdsutkQdpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <tho1.nguyendat@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <tho1.nguyendat@toshiba.co.jp>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core 2/3] Enable secured boot for BBB
Thread-Topic: [cip-dev] [isar-cip-core 2/3] Enable secured boot for BBB
Thread-Index: AQHZ1MS71r2R0sh2P0eeFdRgpuM7Jw==
Date: Tue, 22 Aug 2023 06:54:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB588051DBC3BEBB617CC6B0CA951FA@OS3PR01MB5880.jpnprd01.prod.outlook.com>
Accept-Language: vi-VN, en-US
Content-Language: vi-VN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5880:EE_|TYCPR01MB5773:EE_
x-ms-office365-filtering-correlation-id: d7086edf-a096-4254-39c8-08dba2dc9f8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6WUAbUOQJsplmYdgWIQ/HWYb6c4vdyy0n/VzSrFLAEhwLQx8xMkO+nPsivLohnbd+vT/tGAaT8SHFxBvQv2c4d4uKOtqh1kLzb+6OMw0VjmAMjcV4xBeM38TSdCe2QntE2yLvT3XKkVPWq0n6BqWCFQcSADG/ZOLAk7cWS+NtdpltOlWxuCLow0XlxXTV7WOeS0PMIbGKEm0MZojkZJr4RZbIqo2Dj5flpSro/40/Y+G0LmPLHtgsXNHh+AZWHgIFvtXlVbtxQmmjClO7a7ZI0M7NU+rJ0HOYaZlICzpe1wjRd7aMzSFvwcoZiAKRJFCeGiaIYytgSgGdDa0PchuR0Ij+reV12ew5f5Jnf6JTGpphz3Iv4CyR62iwuiyar2/v1KlDIY8ocBA0LDsX8bR/wsUetwuCzbpJzFZxFRAraDh/uI4+mjTqValK52q5zZyHJg9yuwVKTlYK2t3M06YLtzI+79Jn38o/mQa8bHNVqnj+90O6+BpFje6L85hF5ot4CrAgIurUmCj89hlOM/nSamIsT7g3oh9xgNTHcXvZQGztnsYOStWLvCYp9g1pmeT+jg1yK3N2IjcEqUefWN45R6uiQosc8QjxT3RPRbYKJWvL0FDBQZx5HsZ0hUoWhpg11tjmptpPpF1rfedcmcH2w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5880.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(1800799009)(451199024)(186009)(71200400001)(4326008)(8676002)(8936002)(316002)(478600001)(19627405001)(66556008)(66446008)(110136005)(91956017)(54906003)(64756008)(66476007)(76116006)(66946007)(41300700001)(7696005)(6506007)(55016003)(9686003)(38070700005)(122000001)(38100700002)(33656002)(26005)(5660300002)(107886003)(2906002)(86362001)(83380400001)(52536014)(403724002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NHpmQlhuZi9IN3Vib0hoK2grMitQNmN5UEk0UlltQmZoMFFReFVHaW9i?=
 =?iso-2022-jp?B?Wis2bTVDNlVma0pUbU1oTU9WbUR3YU8zQlVPVVNCNkYyU3cxK1RHMytl?=
 =?iso-2022-jp?B?Y3NYc2hZbUp3aTQ3Q1BkeS9LdXFMazBpaXEvMVkxeWYwQTVTU3F3THZs?=
 =?iso-2022-jp?B?dW1KVGx4RkFWalh4VU5xNXJ3b0doNXF6SGZWMUFFZmNMZk1tMWYzUWI0?=
 =?iso-2022-jp?B?eTU4RS9XWERTYjdHNC9pWFJzeHhqSkhwNjVaT2UvcEZ5eWpMWWIveXpx?=
 =?iso-2022-jp?B?b21XTkd0UisveVBtSFBhUWNUa0lhMjNMRWRhUGdXWkNOR09sTHo5OUpk?=
 =?iso-2022-jp?B?S1lSNXV4eEFUNWVZVVIyZldtWFE4WDdlaC9tZ3FKWE01emJZZjlsNG82?=
 =?iso-2022-jp?B?bWdzbjlKcWE5V013K3pjekFnaDNtVTZPdElyMGszbEZpdXA5NEdRL280?=
 =?iso-2022-jp?B?T0FYRHlSUHk4RysxQ2RHeE43U1I0YlFHSUJiS29zaVExYlFFcVdKN04z?=
 =?iso-2022-jp?B?dWJBTkNBakxuVWVmNUxTMys5UVV4bHNPbzVKa3d3NlJ1cDRQQlRkRFVK?=
 =?iso-2022-jp?B?UHNHWGZzdnV2dzN6Ym1FNHNpM3dyWERBNFBrRjhYa3YwM0EwbDM4K0d4?=
 =?iso-2022-jp?B?RTF1aHA2UHRwRmx6M1ljejcyNWtQN0taOUh2b0hGUEExSTBmQTF0RmRT?=
 =?iso-2022-jp?B?YnJOdC9mWmZYSXdhK3ZxdWI4cWFkS2tNcHlQZitJb1JrajZZVlRneUds?=
 =?iso-2022-jp?B?NUJhdHM4eXA3MWloekVUVkVZUzI1ME1lMFVPbUx0L0hweFRpcmRORE1X?=
 =?iso-2022-jp?B?Nm9USHhKZm9LQjNUdlpmSHRYTzB6TXFRVjFJcThuTWxDRGpLQTNtSk54?=
 =?iso-2022-jp?B?L3BmOTNhb2MxaUY4eXlPS0dnMFlELzZTNjdpaE1NNlpTT0hkSlV1WmtZ?=
 =?iso-2022-jp?B?a29sU2E4VVUzY2RrQjVlL2RiRm5kd2tsT1NVYkRFRjFvcnRwL25SWUxj?=
 =?iso-2022-jp?B?M1ZVdEhLVFFRbFhZTWc1YVFpZGY2MHlPaFUraHZHTjlvOWFYVWNsUHhV?=
 =?iso-2022-jp?B?ZVF6Si8yWXQ4a2sreTV4Y0l6N1htdVlsdW9YLzJ0ZVZuKyt1RDhmTVQv?=
 =?iso-2022-jp?B?V0VFVHhVbXVaek8yZWFWLzFCOFVFQU1nWDU4UTZCOTRVSjJXYzloTGhB?=
 =?iso-2022-jp?B?KzBPVU93MmpvSy8xTDNFK3dGcG5WYm9PMHVDNmNSbm5RVElXL3huWGoz?=
 =?iso-2022-jp?B?YUNYUC9LREhYMnVOUnpsQ0VlbG94cWtjWG85QkxWU0d5dTFNaUZ6Tm9s?=
 =?iso-2022-jp?B?c3VUREhMOXdyZ2RGNzhKYVZweFpOaGw0M2RmUzBMWGp6b09aNGVIVGxG?=
 =?iso-2022-jp?B?TDczZ2FuV0Y5WTdqV1NnejFYTnRDMGwrL0g0RVIwS3J2ckhoOCtGYnpl?=
 =?iso-2022-jp?B?TTV1K2JCcXZMNHB4Ymw2a01vM0htSXRBUnBGUWJGcSt3YnJTby83UE5V?=
 =?iso-2022-jp?B?QUhaVXBQRUttTVpycjdTWDhSTTh3NVhjQ01peldYTlU3NTRuUFRKZ0xQ?=
 =?iso-2022-jp?B?THZGM3NzN2MrVzVKaDdydU0xRUZkbFNjSU9hZnlSRVN2Y2RFK2toOHpD?=
 =?iso-2022-jp?B?OXo4dFpkb2gxWnhnUjNteGIyaXhnODhGZ1d1aTFwZWFtY3FLL0dJSmxW?=
 =?iso-2022-jp?B?dWV2NW1MTjBvODNRSnE0Z1AzUEErNmZaY1VFeGpyTlZDY0tHaFZyT3gr?=
 =?iso-2022-jp?B?b1ExNUd1dDlsYy9DT0JHejBxNzhqOC9iWlhMS1VBUmQ1TkF3MDBGQUpx?=
 =?iso-2022-jp?B?WWVRUzN3bk1TcytwOWFuYmJCb0pQQ2l5MlE3alhTYmQ1aExBMnVZS29P?=
 =?iso-2022-jp?B?L1pvdjhwV1k4M2t1ZEhmNEgwTE5hcThDT1ZqL3BQS3ZaQ1AybHlKM20z?=
 =?iso-2022-jp?B?dy9tNVJLVG1pYmxORU5ieFBUNWllOEpnRGNTbnhDR1VsRm42UTdURDVJ?=
 =?iso-2022-jp?B?Zk1wYytBeUVKQVZDeTRiaHo3ZUVzLzJ5ZFk1TGNMek5abEs1RVk5Ylhu?=
 =?iso-2022-jp?B?ZTVyT1BrY2lKV1JwWnI5K1FydkFPdHJoVHBUdGNLMGRsWXlpeFYrSnp4?=
 =?iso-2022-jp?B?NWFkbFNDTG5MaXdrSGFoQjBpMkxGbDhxa2tkTHpwQ240SnhidU1zWEpP?=
 =?iso-2022-jp?B?QWpOdi9ZWDNHM2RqQ0E0bVBDMXRjQWM0a0VoY2JhNGZmek4xR05rbll5?=
 =?iso-2022-jp?B?ZlpwdzFUWWJ1VDVoYkk5alowV2VOL2dCelFQZjl0T3cxZ3RTN3NEQlVq?=
 =?iso-2022-jp?B?TTFzbmsySW84cnczZ1hJV3B0bWJQeFM0N2c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB588051DBC3BEBB617CC6B0CA951FAOS3PR01MB5880jpnp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pNgHnxuXndWnedjsUVyD28xBqHgWr3lOn5pj+c2Wo8cEqUBIrwHjK0XmF2sD7KQOgw8tlf8ZPRDFqIIf+nl4DLh03rlzkC0ImL8dnrDR+RwTU66uLCLNQam4uJZd09Cm1tS+wN2HT4A1APnLg87ZZaGS1JjBLxZ8KmBGLf5JnuJyFnLEGlk9v9O/2iH68c7Pjg/ggbiT4rib1KEFmhSeR9awk7oH0sc9CFmXQ+fB+EPCotbBI+diStCi7nk2sLNV3EO6mj/AlYOa5TZIjGP6dXZB1MOz4lTTGtH36hogvqid5CM+QfO34Zh3mjb3mIOvg9B7XxMHGUYs6rKI7sauPssG/MmX4C8z9Q+fgZgKDUhJQtNCO7YYNy6LtrcNH6u0ZBYRxna7Mf9p8x+IWMUun+ILyvrshUM6p4r395M/ki2TPaKW48+kEiWMXQ4y3+IMF5NIxq2VRcfI5mxh5Ow0VTPj4jBZgJ3CzG+FR7N4Nh7PS52eHitltDQXMzgNTKjBAKPq7vqna9Mc1Zc9Rug57lkEh5sMYCtOM7PEPkXx3/plpiDGuBO3SDcuuYigCzEWRLT9Uxt58hvwYWnexPt3qn2nZrRlODiGrerv5VdaKQJMBhh9kVgC/izdM94TTsMdDFgtniAe1mFML++VU3/647fXHvTjifd1C+YpSdbwHsin0nCBmm4KUNlhZ4EcY/gJGLgB10sHOH4AfSVx//YzNbt2gsXIFHNA+hGSsk8hCrtJDNTyh7QGSgMh2RysR1akjQWh3zX8esAv8o73coj4JjwT+6+yhHOscL0ZoMV+ve/iHr9Gt5gIvyZARdIp2FdBHlLgqIYT38da91B6+ZxI/Q==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5880.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7086edf-a096-4254-39c8-08dba2dc9f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 06:54:25.5858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7OV3eBixWd+DkST1S+52MSsxP2Xm/U4W13obXA9Bud15OScsglLOKTVqqH0f3zIpblJo92k4DSa8grE43ADW7TWVuzXSp9lyd+eZSD2pxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5773
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 06:54:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12813

--_000_OS3PR01MB588051DBC3BEBB617CC6B0CA951FAOS3PR01MB5880jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

From: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
Subject: [PATCH 2/3] bbb: Enable secured boot

Signed-off-by: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
---
 wic/bbb-efibootguard-secureboot.wks.in | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 wic/bbb-efibootguard-secureboot.wks.in

diff --git a/wic/bbb-efibootguard-secureboot.wks.in b/wic/bbb-efibootguard-=
secureboot.wks.in
new file mode 100644
index 0000000..504e2d8
--- /dev/null
+++ b/wic/bbb-efibootguard-secureboot.wks.in
@@ -0,0 +1,13 @@
+part --source rawcopy --sourceparams "file=3D/usr/lib/u-boot/bbb/MLO" --no=
-table --align 128
+part --source rawcopy --sourceparams "file=3D/usr/lib/u-boot/bbb/u-boot.im=
g" --no-table --align 384
+
+include ebg-signed-sysparts.inc
+
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.verity" --a=
lign 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_U=
UID_B}"
+
+# home and var are extra partitions
+part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --fstype=3D=
ext4 --label home --align 1024 --size 1G
+part /var  --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var  --fstype=3D=
ext4 --label var  --align 1024 --size 2G
+
+bootloader --ptable gpt --append=3D"rootwait console=3DttyO0,115200 omap_w=
dt.early_enable=3D1 omap_wdt.nowayout=3D1 watchdog.handle_boot_enabled=3D0"
--
2.30.2


--_000_OS3PR01MB588051DBC3BEBB617CC6B0CA951FAOS3PR01MB5880jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
From: Nguyen Dat Tho &lt;tho1.nguyendat@toshiba.co.jp&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<div class=3D"ContentPasted0"><span style=3D"">Subject: [PATCH 2/3] bbb: En=
able secured boot</span><br>
</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">Signed-off-by: Nguyen Dat Tho &lt;tho1.nguyen=
dat@toshiba.co.jp&gt;</div>
<div class=3D"ContentPasted0">---</div>
<div class=3D"ContentPasted0">&nbsp;wic/bbb-efibootguard-secureboot.wks.in =
| 13 +++++++++++++</div>
<div class=3D"ContentPasted0">&nbsp;1 file changed, 13 insertions(+)</div>
<div class=3D"ContentPasted0">&nbsp;create mode 100644 wic/bbb-efibootguard=
-secureboot.wks.in</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">diff --git a/wic/bbb-efibootguard-secureboot.=
wks.in b/wic/bbb-efibootguard-secureboot.wks.in</div>
<div class=3D"ContentPasted0">new file mode 100644</div>
<div class=3D"ContentPasted0">index 0000000..504e2d8</div>
<div class=3D"ContentPasted0">--- /dev/null</div>
<div class=3D"ContentPasted0">+++ b/wic/bbb-efibootguard-secureboot.wks.in<=
/div>
<div class=3D"ContentPasted0">@@ -0,0 +1,13 @@</div>
<div class=3D"ContentPasted0">+part --source rawcopy --sourceparams &quot;f=
ile=3D/usr/lib/u-boot/bbb/MLO&quot; --no-table --align 128</div>
<div class=3D"ContentPasted0">+part --source rawcopy --sourceparams &quot;f=
ile=3D/usr/lib/u-boot/bbb/u-boot.img&quot; --no-table --align 384</div>
<div class=3D"ContentPasted0">+</div>
<div class=3D"ContentPasted0">+include ebg-signed-sysparts.inc</div>
<div class=3D"ContentPasted0">+</div>
<div class=3D"ContentPasted0">+part --source rawcopy --sourceparams &quot;f=
ile=3D${IMAGE_FULLNAME}.verity&quot; --align 1024 --fixed-size 1G --uuid &q=
uot;${ABROOTFS_PART_UUID_A}&quot;</div>
<div class=3D"ContentPasted0">+part --source empty --align 1024 --fixed-siz=
e 1G --uuid &quot;${ABROOTFS_PART_UUID_B}&quot;</div>
<div class=3D"ContentPasted0">+</div>
<div class=3D"ContentPasted0">+# home and var are extra partitions</div>
<div class=3D"ContentPasted0">+part /home --source rootfs --rootfs-dir=3D${=
IMAGE_ROOTFS}/home --fstype=3Dext4 --label home --align 1024 --size 1G</div=
>
<div class=3D"ContentPasted0">+part /var &nbsp;--source rootfs --rootfs-dir=
=3D${IMAGE_ROOTFS}/var &nbsp;--fstype=3Dext4 --label var &nbsp;--align 1024=
 --size 2G</div>
<div class=3D"ContentPasted0">+</div>
<div class=3D"ContentPasted0">+bootloader --ptable gpt --append=3D&quot;roo=
twait console=3DttyO0,115200 omap_wdt.early_enable=3D1 omap_wdt.nowayout=3D=
1 watchdog.handle_boot_enabled=3D0&quot;</div>
<div class=3D"ContentPasted0">-- </div>
<div class=3D"ContentPasted0">2.30.2</div>
<br>
</div>
</body>
</html>

--_000_OS3PR01MB588051DBC3BEBB617CC6B0CA951FAOS3PR01MB5880jpnp_--


