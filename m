X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web08.3431.1657865055496335335
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 23:04:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154, mailfrom: shreyas.karmahe@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 26F64DhB003052; Fri, 15 Jul 2022 15:04:13 +0900
X-Iguazu-Qid: 34trPGj2OClZLGdXs0
X-Iguazu-QSIG: v=2; s=0; t=1657865053; q=34trPGj2OClZLGdXs0; m=qjKJ3lU0ELeZ6358JXAVO0v2uJVqX90fvQASBHztGOs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 26F64BJi033422
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 15 Jul 2022 15:04:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8NSEgFHMl/uYSyNDEV/dMYWSoBoDWjmWXr5XWn7qvYBimXzWHFw9BM56nq/1yyEW5tOgDATSwpv8/l1diogAbRZYq400tNzBf9FNz1/p74/PGm/JYuCQHM9LqTXddI2qFfv0DhKZIOVT37oQs+dvbgvKmGyuOzobaANk8tPq8mMwrE1ZKizyWlAZJeaYwSDSx1fL5HsEPOMjaNPy+xGUL3GHbzDyyQrl2llP2M1x1Pz+6bQumJniS4Sf/27lk+9VcBXQxmCfLnPvWThUMmd0HmKaxkuc47lohknakPdKl+eViyAC6NzfXVQz2sehgqsJH7NCdDWcm3iQaquIlh9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2QCf5kknoiefDQxviVRj4/ePYyZZQ6z9Ulz8JK/kR4=;
 b=USgPxiJFF7EumuzxENXunGOcC2uxcm4Dbn+OMlmDWAbLFRwLskRH3ZbuJeMN5s8Wi19aBu/lFVyEgGMVI1SUPOlCakU1Jx4KaL3/DhzDjW05HMkzKFIohP24XN+52E535dmokMsY9y1od4bS+AmNg7ZAdzir9HVJYmhoN592j0h0YDS+dceTPuUo5iNz0Hrzlziw4C2fJC/QBuwmSECCCKdTt4uE5YVcpcCVs9UYRFyxKc0ohD050cZ/rY+lSsUOThlweb1mcPhegAB4bVLAVFKTL+Jdm9BR3HzStfSmAzDjBqY0GLNUoIzZSd5t1eNAQznc2M15aHRLCCNoIU2oQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shreyas.Karmahe@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <Venkata.Pyla@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core] README.secuirty-testing.md: Add steps to verify CIP security image
Thread-Topic: [isar-cip-core] README.secuirty-testing.md: Add steps to verify
 CIP security image
Thread-Index: AQHYkp+Gi/Kngep1nUetbiCCKqV/Wa1++yuA
Date: Fri, 15 Jul 2022 06:04:09 +0000
X-TSB-HOP2: ON
Message-ID: <OSZPR01MB887721281A65202BF4563431DC8B9@OSZPR01MB8877.jpnprd01.prod.outlook.com>
References: <20220708075113.3917386-1-Shreyas.Karmahe@toshiba-tsip.com>
In-Reply-To: <20220708075113.3917386-1-Shreyas.Karmahe@toshiba-tsip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b438a784-1bd0-4e6c-d371-08da6627d5af
x-ms-traffictypediagnostic: OS3PR01MB6902:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ylWMEyTjoIx1dsjcaxAez+y7StiUql9McoPRWF8t6W47XF4Sy6S9/iJjcfXG1pDcBgm5SzvktHz5wankEExWJprLy1MegJcyt40xbkgVHtymHbx18Xa3XVjwF+/lSwyEXYkAY/m0tTDVKaxXx6GVRZ1v4Lh7MnslUfVQ4Ov6IQZUux5kkuToLH07lhd6lQuFgRSTvSUHGpQGWHJwj+G+nQ1HAqiOhU/KTA0ZN/IJNQX6yFz7/RebrT4QRPTnXfrsoAZnrpW/UwyMOh/ot3XemyRZZDpc+arxKK8tHqi/ejZnTonYqwhAkINwdow06aAAFr7pvCYvPRGa9hPUVDi5q5x6Y/nKtn1ZDSAbZ46SzJhjHL1EOhCdoya2R5vWySW618qaMv6DhltAevqBX5QJjjLAru/srlfrzG6pYmttYT5AvyMKNEe1tBXvftvy3RWiUiIVVuF8oxPdG37DsngHWg9a/Tp4f4FWSuFKtWLqX1PnwAVDtj7+mbsWqGs6M1/dXzsLhP+j1KuX/3AxXTteD5n+d/rkYGHQ5wtGEigljhuU108I4du2CbPkwWLBoVDmFlM704ZrtEjdqw+kTCYba+7xBQGu1j+WDpwJ9IKUV6zplg4HsrXNpgo4qBtsOPZ/95oJ36dxzz0BkWyjtpGzGAV630qPKHAK4n5NhEX7t7h+OBamWPJUK1OnTDsQdzIhvFmFH1rwGGRVhdLmDbDJSpiUdWTviTQWSE6cFZok1BhaOLYMK/WTZNfgpnm3TIwFmnseT075HA7DWklCo57t/KEuZ4XY1Lhm+GFPTwyD2cIVMEBA0VNBELbUmK3h2Tzp7Y71PMqx6wY2pzVjeX7tmWesu/0lG85ytL4s9GM2x6LIG5ty38oL8ST/yEf+qrzIabSKbFffRg+GnCuxDXbhQoXs4hDpEuW5pX2d170P7mE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(15650500001)(66446008)(83380400001)(52536014)(86362001)(38070700005)(122000001)(38100700002)(8676002)(4326008)(66946007)(66476007)(64756008)(66556008)(26005)(966005)(5660300002)(53546011)(110136005)(41300700001)(2906002)(8936002)(9686003)(76116006)(186003)(55016003)(316002)(71200400001)(33656002)(7696005)(6506007)(478600001)(107886003)(54906003)(47845001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?aGhHaDJENmhjZ1o2eGs3Qmk1UzZSaS9mbko0L3NhbUtqK3lwZ2JwVE91?=
 =?iso-2022-jp?B?MzRNVS9iZ29yTjd1S3g2aU5CUWtIM1o3NE1BeWJjaUVSQUNiNFRVK0Jk?=
 =?iso-2022-jp?B?dWdJOFl6MmNrUlRCZlcrQ1hOSGl2UEF2aThoTjFxYklNMXUvTC9aSjRM?=
 =?iso-2022-jp?B?YnZNd1hTQ1dwQ2RXV09iZlVCSjY3RFRMdDJyeElGa1oxME9xdUZqejY1?=
 =?iso-2022-jp?B?MGpMTTZlUWFWWmxCVGZaTXRxS3I2NFRiV1pWQVlJN0VLREd4cGpWQVRu?=
 =?iso-2022-jp?B?TGlyZnNNN28wT2xZR2c5VnNpOU9WM2NMRUw3T2tlWXNydm5MYW8wQkk2?=
 =?iso-2022-jp?B?QUFZMy9PRldwZlRLY253a0J4V3hpUVV4NW00bnNDelhEUGRrSzg1b3ZK?=
 =?iso-2022-jp?B?dmdQa0xaNDNOM2ZCM0NWYXUranNRVWZTTkc4Q3NiMkM1bWxuNEZiR1dh?=
 =?iso-2022-jp?B?S2xRT0k5RldobVVpNFYwU2VrVG15ZXovSUdKQXVLbWNvSUFzSDlLRCtT?=
 =?iso-2022-jp?B?eVBxWE5kck5QTEN3SGJWeHBXbTRIK2gxc2NScUNiMHRQaHRoRzQzbDFk?=
 =?iso-2022-jp?B?cllLY2R5T1ZoRllrZUFwNTRkSnhaLzkxMWEvczFVV3loaUV6U0N4N0Va?=
 =?iso-2022-jp?B?RWZOUDVnY1o5cldSZEFuZy9HNC9ZbkpWSmwralZzM2lCcE5mNU9QZ21M?=
 =?iso-2022-jp?B?dHZoN3BVbUFtVk55V0p1QTJNenRXTUM4b1YyZFNPcTRITExwdEovL0d0?=
 =?iso-2022-jp?B?NnAwWUUxem1RbjFSNWtzQTJJQnZMUzQrM0RTc04zalczZXB3T0ZYNHdO?=
 =?iso-2022-jp?B?cHJWZUZrbURrNnhJMnNMR04xS0o1MHhiUjQvb2x3Z0w4WXlkSnpzYXZK?=
 =?iso-2022-jp?B?N3F6dTZ3Qjd6aW4vQzZ2TjEwQjY2STFaY3FHelZWU2Y4S1pqWGZrQldR?=
 =?iso-2022-jp?B?SFpJUUpQZHNwalo4b0tEaUc2aTVFVkwrU2tNWG13R0RoMGRFc2hXK1ZJ?=
 =?iso-2022-jp?B?RitmNVlYc2RYeFlOaEhZR3FDQnZ1dGFiVFZMSVZoS2E4V3hiYWl2dEhs?=
 =?iso-2022-jp?B?NEhrbmhPSU1oY2g2eGEvRURKWW8zQkVmWE5Oa1BXSUxFejA3dEcxdzI3?=
 =?iso-2022-jp?B?MXZBQnB4b2EzcFViWTM0YzFZZXZMVVZHbWNRR2l2bWNuOUYvRFJjb3RX?=
 =?iso-2022-jp?B?eFN1bHdZMStJcGtXdTlJRHYwcUZuSjhsMzlsdkNwRW4wa1NNcVJBd0RR?=
 =?iso-2022-jp?B?anQvN01sbXJOV0ZGNG9NV3Z6YlZXNFJ1SDAwOGVtMzZuMkRQakRtbDIv?=
 =?iso-2022-jp?B?am82YTI2d0NCbXZrRzdTSmdrSXcrYjRxZ3BxUzBncmtDSlJNOWxKdjJP?=
 =?iso-2022-jp?B?WHIwYkY4VXh2bEFBNFhJSkZGNFpYRm80bmNKckJZM0d6d2lwTDlJbU1o?=
 =?iso-2022-jp?B?L3UvVm9IeVhNckZic1N4MDRlNlI1ekV1aFl5Mjd2VGxHNG4yU1JPSnNo?=
 =?iso-2022-jp?B?QldhYVUyZ1lLT25qekM2SHBKOGQybEQvRXBWUUM3SnFiRjdDSXBOL1Ev?=
 =?iso-2022-jp?B?Y1Vyd0Z3MHRqV0VWbDNFYzdLOWg3VUtCclJhQ3N3TXJJVUFPNjlydmdz?=
 =?iso-2022-jp?B?Q3ovdjNsNW5ZcUVEak9sM2poMWZURFF2M2F3MjNKZXJReTdEd0RiQ1c4?=
 =?iso-2022-jp?B?YWJtaEVrUFJzekZ6ai9VdndEczJNMS9aYkdUZWVsTGp1WTBNVHBTWG80?=
 =?iso-2022-jp?B?NmxxN2h1b2cvaldmcVRWQmpvVVJYYlJicEkxQjdtZUlMUUFWQ2RFZVRj?=
 =?iso-2022-jp?B?WFg0UjFnSFJZWHhKOFY3WXNBOWNSSWNKTmFMUmlRcVA3THZkQzJLeWlF?=
 =?iso-2022-jp?B?TGlRaFZGYXdQSHRPRG93MlRScjVlU3NwRE15dXJjdjNPeEh2d1Rpak1s?=
 =?iso-2022-jp?B?SktHamJsOGNVNlNhMzl5UHpLaVNPWnpJczgwZGU2M052bDNsY2JrVCtn?=
 =?iso-2022-jp?B?MVdSUXRMYTRZZWFnTHcrNSswQVlZZFF2MVBtN1JMcjZMSHRtMDRsMndj?=
 =?iso-2022-jp?B?QzNsazBhVGc3RXNPTSthL1BOdnk1b05GamNFLzBBMkdSYzdLWFFrS08v?=
 =?iso-2022-jp?B?V040b0Jra1RJaU5tQkdHL1VJbWlyOERjMWZmcUpMWWQ2WVVJTEVGaVpW?=
 =?iso-2022-jp?B?ZzVWLzh4bTkwa01ISWRGUTJ2bk5RTEdieUcxc1BHbUVFWGcxL1RwNDNS?=
 =?iso-2022-jp?B?UmtlT1J2L2ZrRzB5ZGhmeTRsaEozNVRXbGZzRnNxWVZEZ2tWcG5wbHo4?=
 =?iso-2022-jp?B?eDUzS2lwdkpFNFhlV2NxbTJ3MFVxcHNxQmc9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b438a784-1bd0-4e6c-d371-08da6627d5af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 06:04:10.0549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wWPHqV6Z0r2ym+on/UIkHhx1OoiwukiIlE0oZZOA0/yCiqvYZeISdzYe18Jy0P6N0fAyGt+lMQHk0s2o0ZrJBN7otNY1MBuF/WRT8J0lSg9ZV4iwauope6Edx5UWuag
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6902
X-OriginatorOrg: toshiba-tsip.com
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>

Hi Jan-San,

I have shared the below MR patch request that covers the documentation step=
s to verify IEC Layer Test on CIP security image but unable to see this req=
uest in mailing list.
Kindly let me know status of this MR

Regards,
Shreyas
-----Original Message-----
From: Shreyas.Karmahe@toshiba-tsip.com <Shreyas.Karmahe@toshiba-tsip.com>=20
Sent: Friday, July 8, 2022 1:21 PM
To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
Cc: karmahe shreyas(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Shreyas.Karmahe@=
toshiba-tsip.com>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dine=
sh.kumar@toshiba-tsip.com>; pyla venkata(=1B$B#T#S#I#P=1B(B TMIEC ODG Porti=
ng) <Venkata.Pyla@toshiba-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9=
(=1B(B =1B$B""#S#W#C"~#A#C#T=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core] README.secuirty-testing.md: Add steps to verify CI=
P security image

From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>

This document helps to build cip security image and verify the IEC layer us=
ing cip-security-tests[1].

[1] https://gitlab.com/cip-project/cip-testing/cip-security-tests

Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
---
 doc/README.security-testing.md | 80 ++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 doc/README.security-testing.md

diff --git a/doc/README.security-testing.md b/doc/README.security-testing.m=
d new file mode 100644 index 0000000..b29531c
--- /dev/null
+++ b/doc/README.security-testing.md
@@ -0,0 +1,80 @@
+# CIP security testing
+This document explains how to verify basic implementations of [CIP securit=
y requirements](https://gitlab.com/cip-project/cip-documents/-/blob/master/=
security/security_requirements.md) in the isar-cip-core security image usin=
g [cip-security-tests](https://gitlab.com/cip-project/cip-testing/cip-secur=
ity-tests).
+
+# Pre-requisite
+- Necessary debian packages to implement CIP security requirements,=20
+include them in the recipe=20
+[cip-core-image-security.bb](recipes-core/images/cip-core-image-securit
+y.bb)
+
+- Pre configurations in the image, should be added in the `postinst`=20
+script of security-customizations=20
+[security-customizations/files/postinst](recipes-core/security-customiz
+ations/files/postinst)
+
+- To run `cip-security-tests` the image should need additional package `ss=
hpass` and rootfs size should need atleast 5GB, add the below configuration=
 in kas/opt/security.yml file
+    ```
+    local_conf_header:
+        security_testing: |
+            IMAGE_PREINSTALL_append=3D" sshpass"
+            ROOTFS_EXTRA=3D"5120"
+    ```
+
+
+# Build CIP security Linux image
+Clone isar-cip-core repository
+```
+host$ git clone=20
+https://gitlab.com/cip-project/cip-core/isar-cip-core.git
+host$ cd isar-cip-core
+```
+Build Security Linux image by selecting necessary options ``` host$=20
+./kas-container menu
+    Select QEMU AMD64 (x86-64) as Target Board
+    Select Kernel 5.10.x-cip as Kernel Options
+    Select bullseye (11) as Debian Release
+    Select Flashable image as Image formats
+    Select Security extensions Options
+Save & Build
+```
+# Boot the Linux image
+```
+host$ ./start-qemu.sh x86
+```
+
+# Copy security tests in to the Linux image
+- Clone the cip-security-tests from following URL ``` host$ git clone=20
+https://gitlab.com/cip-project/cip-testing/cip-security-tests
+```
+- Add test user in Linux image to use while scp the=20
+`cip-security-tests` ``` image$ adduser test ```
+- Copy `cip-security-tests` to Linux image using scp command ``` host$ =20
+scp -r -P 22222 TCs/ test@127.0.0.1:/home/test/ ```
+
+# Run the test in Linux image
+- Go to following directory and execute IEC Layer test ``` image$ cd=20
+/home/test/TCs/cip-security-tests/iec-security-tests/singlenode-testcas
+es/
+image$ ./run_all.sh
+```
+`run_all.sh` generates the test result in file `result_file.txt`, and outp=
ut look like below.
+```
+TC_CR1.1-RE1_1+pass+11
+TC_CR1.11_1+pass+22
+TC_CR1.11_2+pass+30
+TC_CR1.1_1+pass+5
+TC_CR1.1_2+pass+6
+TC_CR1.3_1+pass+7
+TC_CR1.3_2+pass+4
+TC_CR1.3_3+pass+5
+TC_CR1.4_1+pass+7
+TC_CR1.5_2+pass+13
+TC_CR1.5_3+pass+10
+TC_CR1.7-RE1_1+pass+5
+ :
+ .
+[Truncated]
+```
+Each line of the output will have this \<requirement=20
+number\>+<requirement pass/fail>+\<time took to execute this test=20
+case\>
+- pass - The security image is meeting this requirement.
+- fail - The security image is failed to met this requirement.
+- skip - The test case not supported by IEC layer.
--
2.30.2



