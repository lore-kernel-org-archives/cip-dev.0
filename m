Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCE3C48BC1
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 15:43:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.44090.1707925414456697602
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 07:43:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 41EFhWjM2042687; Thu, 15 Feb 2024 00:43:32 +0900
X-Iguazu-Qid: 2yAayDBj4OQlkP38Yi
X-Iguazu-QSIG: v=2; s=0; t=1707925411; q=2yAayDBj4OQlkP38Yi; m=NsRW/Yq4/RR6Obkf6i1RktGDiSBzMvuUTpZs9neoPO8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 41EFhU603157099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 00:43:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arxv7Ghyd4cXed0BoO6uVwVNSqcEiWAu9gHWT/B/dfgxJKYfBvely8NiAeWefAX8XJ9iWv2jz+3ykmvVhV5AYmycE5QuzGWTRSjkZvJZ3meMIESRQBQScf4uSFgZFX+t9WwKIToqyn6ag7Rqj8XUJYjx50hz1ZGtBerZV/OBm++JemUkAX+mX4aHUVb3KFa1z/EZ/E+xLzs32UPI1cOmaapS8vm4ad2ggGtHadAleyXzyfvnY9oKHFzwzML2MvpaugtoZm8ndDW0TyL61nSK7OHSJaf2V/CUNNGE1z8Jsce12jaFWcrBDGj8MK+JgjvLmtUoHMNyBhdot2/CsZ9XRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0J7vI/ZTyjGKdvr/VyMYo36DM7BXC5GlwFXurpNdxCQ=;
 b=XnCdhfGK7ZX2D6pi//ZFnjxdX0czBOF4bHq7sYUrRrauuHGLKt/MLy82L11+M820KNQHHSc6Otncr1DPyqXIMRV/JtO5dmCaokcjjPLRnHOCe04n/vrbUrxJGrNX99bWixeALysYIJ38LKOkNa201J6Q9ByRbCNBSzTxkQc4qjWHgED7q/MM10sHQm6xMv6QIeh4D8mvng/tUXhQkYiPSzQqBMB47wIeDFLIRiITD72XTkYWJ68vzjUMS/r0rOmQiSOThE39wd8oAh/lNgUUJbBz7FrIHCj9Ziw279cwQJi3e/0zP/GP6exV0g/pjz5yIyVWUtLNsPk6R+Im58at/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
        <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core v2 2/2] .gitlab-ci.yml: Add condition check in
 .build_base to build v2 image
Thread-Topic: [isar-cip-core v2 2/2] .gitlab-ci.yml: Add condition check in
 .build_base to build v2 image
Thread-Index: AQHaX1syoBI2gkdvQEm9T5o/Ajnt8rEJ+erw
Date: Wed, 14 Feb 2024 15:43:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61033A15384ED34E46B22712C24E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20240214153341.3543690-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240214153341.3543690-3-Sai.Sathujoda@toshiba-tsip.com>
In-Reply-To: <20240214153341.3543690-3-Sai.Sathujoda@toshiba-tsip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB5941:EE_
x-ms-office365-filtering-correlation-id: 12d0aa4d-e632-45d0-5b88-08dc2d73b0d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 821nONnUqLqgKyrgDGnZ/+J9Hwbbi3sq+O1MmWcmahfARY0NghwlXIVthrwusULO4zyVQQbJpzff3J6Boz2WaVMAB8mV96gFd83cvsrYJ/Msi8P2Y4vU0nG1MRUTzzEo/NU7JwYtKa1BUmjPp5vGEcsABPrOA/9zWbGr4v8Sx7fIsfgU0ScvFt14zxlGpalX3Je6RMhrgV8mCGHOlsI7BtlVtQf8IOHzjMBN//UFpBel511zE4ynYC0hqHVH3r3WIG+LZ/Cyj0CHqjX/3ZbDfsdJ086CUGiZwP+nxkTQWk73W0dTyQScf+0KOJo1jaiuuu1U9QIHSnmA1wgcL/eXP3dAdVyhwm0AIlaiJ3lghpjpAo8KX2DjZ+RU6o0t7zT0vWehosNrp/kOq1K7lpYK8TfTK5C3fQCR1sI972XJ/qeYDnfIDPFeRYTyLDI1DWauBDJzyoIC30dfCWK1Hqvqnrdsx01NqTV9ItFALxjyV9PliOer/JbbwmHACz+kDWc1hiYhAncMPQbt2I8WYJlwTOTxFioL9p9oKHLD0hTFJp0DrzJsgMsGO3QZBkBxpHcg+uuG4NFRGhiHo4NiQAxQWyYTclktQRwXLaY+ugCoS9ym5/lE8JlmiXL+b0rX4PLp
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4326008)(8676002)(66446008)(76116006)(5660300002)(64756008)(66946007)(66556008)(66476007)(52536014)(8936002)(2906002)(83380400001)(38070700009)(26005)(122000001)(33656002)(85182001)(86362001)(71200400001)(38100700002)(110136005)(316002)(6506007)(54906003)(107886003)(41300700001)(53546011)(7696005)(478600001)(9686003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Z0R5dk8zSlYrdktYb0l2ZldPM2l6MFJPdmxESFBXdzc5bmVtb1UweUZj?=
 =?iso-2022-jp?B?WHNxaGl1ZUc3R2R3eGhkZGMrb2VFRlg0R2M3RXZoWEJPTUxjaXdNY1ZQ?=
 =?iso-2022-jp?B?dlB1YkQ2THV1VEVjNmhsbDRLMWZDa0xueklKcXhLZllzSlN4SEdidGZF?=
 =?iso-2022-jp?B?MnBVVDhvVlovcEx5Q01SVzVkTGxuaUJvWDJRNis4a2V2T1BCMDB2N3NN?=
 =?iso-2022-jp?B?aS9lNVlodHZPbVZJZytKeTlNOExNRUdZUzVkMWtORkFuKzR1b2VlY3BJ?=
 =?iso-2022-jp?B?N0xzcy9ZY2liRWVTNU0wbmFtM0FObjZZNnlocWZPL2lOaHV3aWl6ak45?=
 =?iso-2022-jp?B?cTFXWFJUQklqTThTVVBvL2NGbkJYbXFYbmZDSXpCZVJkTTdoNGwrZHRu?=
 =?iso-2022-jp?B?K0dpYXFKR2l4c2pDanVTQU1veDdnWlZXdlBsVlYrZUxacm1rOHB3RjdJ?=
 =?iso-2022-jp?B?aWZxWFYwSVhhRVhhdVhBR0RodlpxS2Q5ZW05d3FuajlOOUxEY2xHUUtp?=
 =?iso-2022-jp?B?dmVpTjBVbEVaT2JsbnRMRHN6bTJoQkZKMEZMMHZIYVhDTldYa0NvV0FU?=
 =?iso-2022-jp?B?ejVtYTd4TFhUeVJnVlhCc2lRSmcvNlIzRXZsRlBPSEpNd1NBaU5rOWVy?=
 =?iso-2022-jp?B?UHRMOURBRDNiWk9id2ZPYWpmdXFyT3gvY0Y3UWREQXo4VTM3RFdKZU1Q?=
 =?iso-2022-jp?B?VlZoL0tlbWY2L2pmKzBYMVlzckxVRkxmeUlYU0J6Q2FpUnl0c1dNbXN5?=
 =?iso-2022-jp?B?VndGSjAvb2YwWitldFcybm9IK2lrNVZFb1VYQjNQcExTcmZvS1pKcHZV?=
 =?iso-2022-jp?B?empKSjR0NW5TTzR0aHZUU0pyS3MzOHJYeUZDbitEMFhnMkJRNDJEdjJL?=
 =?iso-2022-jp?B?OEdRM2hLdFFubGxoSjZQMElBQ0VEZW9iVHhyczJXSExUenlYNmoveHdI?=
 =?iso-2022-jp?B?UTBBeU9WYnNPQTRhWXpFbjU1WXVYdE1ERUl6MTV6Zm9Xdk80a3owbXM2?=
 =?iso-2022-jp?B?QUtVdVg1OXJaRllpTEFLYURZU1VJZFNIVTFpc2NObWs2TStXMFpSd25q?=
 =?iso-2022-jp?B?S2ZUNjM3VXpmVGlnMVlHVWgyOHVQZmE1dnZhWUgxeDZtYWRnNmJxRnVQ?=
 =?iso-2022-jp?B?bkxmaVV4b0toblk5RGRoMHRURVJNMVIxVzhjL3lETE1HMjA0WWNib3ow?=
 =?iso-2022-jp?B?ZnVEdisrZTZjdzZuU1FsV0ttNHlZRG55eGNDK2NhN3dTUGR3TmVLK0li?=
 =?iso-2022-jp?B?czJGZlhYYXA1eDh0dlBPVjBKc3BFSy9GRG5QRTRMTklFdWlrN3VPYmNo?=
 =?iso-2022-jp?B?d0lyY2FRNkhMR1oweFd5bnZ3cDAvS3FoQjNHK3RUdXNuZEtHbVJuSkRq?=
 =?iso-2022-jp?B?WWUybGc3cVo3cUFSZTVUc1lJSWhiMDk3emMvdGJzWXVKaVJRdzRHcmRD?=
 =?iso-2022-jp?B?d1QvZ29qLzVhdkpRelFoY2tTOEdSOWdUMS85QWc4NTgrVG42V2tnM2F6?=
 =?iso-2022-jp?B?WWRNZVIzb2c4Y3JWSFBRR3Jyb3ZIbExVMGVaZFRPT3RtNWNqcWtlbHUr?=
 =?iso-2022-jp?B?eGNFYnBBSnM4QzhRR3lGU3A0UzFFUWlUSWM4bFphWDRXZlJFRlkxQnBs?=
 =?iso-2022-jp?B?Y0pzOWVsa2JiT1ZabUU4SkZobENra09CemxwRWVHOHZaL09XNkpJNkxB?=
 =?iso-2022-jp?B?N3VMZndSMFFFZnkwSzRERW5wVTJGVlBHZENCMGhVTGRGNVFpWi9KN1Fu?=
 =?iso-2022-jp?B?NVJ2akRxNmVYejBLNFhRQjFnY2MvdE40WHVxUUdtdkd3MzZQWHdKVndp?=
 =?iso-2022-jp?B?Z2ZBOEhNZE90eERxbzl1ZmtybGNwbFM3clFHZWczbnpVWnN3UFVIRWhB?=
 =?iso-2022-jp?B?L3Q4YjJBa0FaZWhFRlNEcWxkb1J2QlZRcTZ2TnlLOHZ1dCt3SEhtakQ3?=
 =?iso-2022-jp?B?bVVmZjFVaWUrNllGMXkvMS82Vzl2bjVKeTJkb1hWQkQ3UjI4WlZCVjF1?=
 =?iso-2022-jp?B?UUxIczhzM0IrSlptSk1XTyt5Y1VEYjZVeU5MNGpjaXFkWDdkVVFTZ05p?=
 =?iso-2022-jp?B?cnFJbDdUdlhZQlRtR2dBVTBYY3BCYUlvQVZPQlZaRm5yVzZLaTJ3cDBi?=
 =?iso-2022-jp?B?ODQ1cVVubzJTNDI1VlNja3ZrY05XN3pSTEdiUlRrNGVlWFI2UEJKWmJk?=
 =?iso-2022-jp?B?YWdVcEhaSlBUZFZnK3VUcEdseWJkUlg3VkFCNTZ5MXJCcXhKbnN1VWYy?=
 =?iso-2022-jp?B?UHJyNnM0M1pqeUFpTEFqVTlScjV1aHZIb1k0UkcyQXREMTBocmFseFcw?=
 =?iso-2022-jp?B?RE9WMlAvc3Y2bk9qN3JCU3daTmVYM1JhUXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d0aa4d-e632-45d0-5b88-08dc2d73b0d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 15:43:29.0225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25Unhw37hvpXKkJa7MazZQvNRkxb7cC3NHF4K4yEpv1sfQpwLCzyodGbyMX1h0kVJMdFujNp5VYAKLxO273NpMKJ3RYMJOR2jGKWDL3ioWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5941
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 15:43:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14978

I sincerely apologize for sending incomplete patch for this file. I request=
 all of you please ignore this v2 patch series.

Thanks and regards,
Sai Ashrith Sathujoda

-----Original Message-----
From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>=20
Sent: Wednesday, February 14, 2024 9:04 PM
To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; dines=
h kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core v2 2/2] .gitlab-ci.yml: Add condition check in .bui=
ld_base to build v2 image

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

To re-use the built artifacts of v1 image, the consecutive build must happe=
n in the project directory of the job. So if use_swu is enabled, then a con=
secutive build with a minor recipe change is done to get an .swu artifact f=
or swupdate testing in LAVA.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml index 4f87ec3..8ce7118 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -25,6 +25,7 @@ variables:
   dtb: none
   deploy: enable
   deploy_kernelci: disable
+  use_swu: disable
=20
 stages:
   - build
@@ -66,6 +67,12 @@ default:
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" =3D "enable" ]; then scripts/deploy-cip-core.sh ${r=
elease} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
+    - >
+      if [ "${use_swu}" =3D "enable" ]; then
+          echo "PV =3D \"2.0\"" >> recipes-core/images/cip-core-image-secu=
rity.bb
+          kas build ${base_yaml}
+          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${d=
tb} ${CI_COMMIT_REF_SLUG} ${use_swu}
+      fi
     - if [ "${deploy_kernelci}" =3D "enable" ]; then scripts/deploy-kernel=
ci.py ${release} ${target} ${extension} ${dtb}; fi
=20
 # base image
--
2.30.2



