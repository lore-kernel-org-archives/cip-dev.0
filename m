Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E6C54EBE
	for <webhook@archiver.kernel.org>; Fri, 13 Jan 2023 15:25:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.90093.1673623528307252490
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jan 2023 07:25:29 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 30DFPNjf017636; Sat, 14 Jan 2023 00:25:24 +0900
X-Iguazu-Qid: 2wGrC6bcpqzwBNE9se
X-Iguazu-QSIG: v=2; s=0; t=1673623523; q=2wGrC6bcpqzwBNE9se; m=5UHBctCTbUnh6aiiQuSHjn+c21oqptpcB4hhbGJX54s=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 30DFPLDA022446
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 14 Jan 2023 00:25:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESUFY1SiRb4NRaHsjZdfa1k6eUUYDm8yEDFDgrpT5wH/UGHWlnky2aCVrSp5VSJRoQ8IUrpVHxLURiXo7wm6fPTFelB6eVU2pqiXbHPb4MrLy9TB0uU7PdPbMvHmBptP5cmQPvfBZjtbj4/j9vhxowD3rwaMjV03SQyBdLSOg1tNoZ0H0twZHNiBj7KDkpVUURqn8qHxBtv2shBlWQx3oYuXqtDPc+fuz2ijRE0dRMSAOJYtYxx5RTLhRC1SjjJB0NCrQxUM52vt+57jB8jmSc1mtO03G/XDYZtX0R+bt3F/5JeYY+D+C6rHpe/4cMQfz408rzdEkMc6hjQK72Tvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH56Y4OOveJaYXHL4+U2sFuj3rbAw77NXz5EBOq3g6c=;
 b=FhBR40sgabrxJW5m4J6szXc3DcyxvSHYb37iV2z8pZHSfGp0n/KQTNjUo/6biZleQotBY7tedp8wqaUPXGqUrgFNE4te2/kiC9pMPTwPmSIC/x+Jgcqb+hWFywqV+VFKEeBWKIGVcCTvttrk24SWyJDkV4h185o9yIUzUkVSezNKnSR1R1Xe5yhzigsuarwsL5gE95xsDegyHFURm+ZzG06IU0xIUPNSQnukvwIrqlaNu/Hyy6j8LeOKJXnp0lHFQ3o62t9uEdyV3hXRchY2vusDpDkIrDUZatuVbTM+z9yjoO8vgf3dakzbqzIPWUUeyisxa8mmsQwUNKInFMFYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <chris.paterson2@renesas.com>
Subject: Need help to configure gitlab-ci for building isar-cip-core image
Thread-Topic: Need help to configure gitlab-ci for building isar-cip-core
 image
Thread-Index: AdknYw0eAV4MN03QRAi0yw0Uu+fPzQ==
Date: Fri, 13 Jan 2023 15:25:19 +0000
X-TSB-HOP2: ON
Message-ID: <OSYPR01MB5542EA0128B0A2ACBF60C686A4C29@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|OSZPR01MB7818:EE_
x-ms-office365-filtering-correlation-id: 706e3393-f0cd-4a4c-c23f-08daf57a6190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cp0sbjX0nXLOPK9wYX30urQ8mwiAZN6Pf5kUYtoH59bm+u6yRPFCWUrxVMziq130HlV8Wn+uYjViu2Hv/5+e27fNlY3m6la3UPCK0yTIWNxy5PEaUrWdw4pQIg8V68ey1qTf5BD1ybA0XyNKKqQWR+E58VCN6FtibGVRowBNZs/5i3ybckvCipgWVd+QK+sxENTIEF/+BE0m2h0AO56NHsl2gXSsl2uBLfCYz1gtDvlWZPc0nn/6LqRqxWbhSaSETANBSrJBfd2J6xxatS7eFAdxl2mrOm/Ntitcelq8vB9WX4mgl9Rfd3D4h0BeWh48z1YbFmr7DWqSPq4BHy7P6en/hItW3+f52VRkCkWrG3cbRgC1pxzOwXPZboQY6sg3UIeE9593GFfvAp5G6nHJ3i4PvFBUAcHn0XowBa+BCLCTGtqJ0lsBP/knEfgJdcRHOaeQ0mYwbgq4acazVQbxEtriF/asaLK80LDxIR38ASA8lOJD0SI+tchEXT+gRU/cOjG+qmqhzgjuvEyy5vyRNUXuajG76BH2/LVzr2/aHv9T0G1S/zYq2e8Y0fFLkjbBDilfx7KyfYQHgYq/CxmzpzDnP0s/Y/UedrZdEwlGjnBi4NeDI2hM/d8tIS2ytkly3LwrABIpkNzLcNelBwTSwioajEZ7Zw7G+twh4PTYAQ3jBARJCswLnnYN9CsN2n1xgZg3MkN4h97QjHGZ5VG6WN0UwSUU3z01N9gVMCjXFSA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(478600001)(966005)(71200400001)(86362001)(38100700002)(7696005)(2906002)(186003)(33656002)(9686003)(6506007)(55016003)(122000001)(83380400001)(26005)(6916009)(4326008)(66476007)(66446008)(5660300002)(64756008)(66946007)(76116006)(52536014)(8936002)(8676002)(66556008)(41300700001)(316002)(54906003)(38070700005)(84970400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RXoxblpOSkt4aUNtRWVsOU5zMmpZWXNDd21STG5tT2VacnZUaStmYnJ6?=
 =?iso-2022-jp?B?RENWbEVWMU5jNE5QcGRTaGFBSWtaUWk0YmhQOWhEVFNyUWQycHNTNjU5?=
 =?iso-2022-jp?B?R0VCK2RpY0kzeklBTnNuNFB0YU1lRStaaXE3cEZRc081MEJHQ2l2bmRW?=
 =?iso-2022-jp?B?VU5LVjdtTWJQenRRRG5lZDV6RERkSzZEd3RTMEtEVHhZdkpvRUM0VXU2?=
 =?iso-2022-jp?B?dVdncUlzbVA4QzI1WmNNR0xRQlhjZ2pCUk1raCtoRWlqblNrSFM5RmZT?=
 =?iso-2022-jp?B?a0RNL2tsWnVabVNFajRhdWJrdnduNU1tRWF3bUV3Y2Y0YWlHYjc5UXA1?=
 =?iso-2022-jp?B?S1hNV2xVcS9wQStORGpyczQxQUlxMDZKQnhLS0FkWGdXSmUwR3hlMnpw?=
 =?iso-2022-jp?B?ZlU5MWJQeGVKVHNBVjM2SWkxUjRSdEl2ekYvYVk0VHZsTWtkQ3BLaU1r?=
 =?iso-2022-jp?B?OXNTTm9tenl6d3hIcnAzc2Njb1E3RkFuTEo1MGtLNDlnd2NMelhXWmZQ?=
 =?iso-2022-jp?B?emY3MDYzcGZBNmo4MklKY0MrdFVYL0s3S0pMbmNwZjRXdml3akNXU05h?=
 =?iso-2022-jp?B?eDVXNUc5ejVkcmNaaFo2czk5UDhmVzZQY3l5ZzY1MlozdkE4SHR4OHU1?=
 =?iso-2022-jp?B?QUhRUnIzMEZReG9QM1hOWWp4VmVWRFd2c3o4Q3oxNkx6VllERit3cDQ2?=
 =?iso-2022-jp?B?bG1UZzY0SHRxUWthWVRVdEdXTDAwVGpRQ1RsOTlIalM2S0g3bmJENTdl?=
 =?iso-2022-jp?B?RXlRS1c0V0c2eE5LR0VPRVFoL0xVNDk5aXF0TTFGY2NPYSt0clh5SVB2?=
 =?iso-2022-jp?B?S29aV2dIQk90cnJKZzVzZmhJMDg1THFxa0U0NVcyWjlSRDhsbnJMOU1y?=
 =?iso-2022-jp?B?RUtHU3NyZUdmZGpxbEovSUxTZSt4b1Y3MTRlaU5PZEJjSGRadnRNTkhw?=
 =?iso-2022-jp?B?d2o3bkROQzNVdWpLMHgyeVhlNDdVSThCcnluMjUzM3pSU3M4V0ZxTzRx?=
 =?iso-2022-jp?B?VlR2NHNXa0kyK280emFQYnpXREdYQlk4bEUyRjI4cHRnRE56WFZOTkgv?=
 =?iso-2022-jp?B?SVNGTSttWTV6bU5nL0pxZFM5Wm94MDEvaDdTemxkUW9kRzlrWkpLYnR1?=
 =?iso-2022-jp?B?MUh6THB1Y3oxcEI4dkpoampoK0tnYjVNYU92YjE1eitod3VxVnNJZFJs?=
 =?iso-2022-jp?B?N3hzWjdEeHdlTTF2aXp6NURXNDlxcG5KaXFYMUJzSTF3UG1DSWZIY2xE?=
 =?iso-2022-jp?B?U2tJWThVOWh1WkxYeFE5dEFxaGRPTXRhR0NGV0xLdzVNZnNEbk9LQnpE?=
 =?iso-2022-jp?B?UWh6elRjZTJaNFpGT0RxM09VZGhVZ0xESitKMkI5TkJScHFoOW1ZN1ZX?=
 =?iso-2022-jp?B?enlpRWRpRkFtUlUxWU9xbzkrMzBUV1k0NEFzc1hoVGgvN2FkSEt3MzNo?=
 =?iso-2022-jp?B?UHIwN2ZFZUxoRjExSlpQdzdaSW5RWE81U1NnM2E5ays5Z0t0NTVxTjJG?=
 =?iso-2022-jp?B?K0tNaDNReDlxUEVUa29FS2NWdnRXckNUeUkzY1QzQ2c2WUpuWkhEM2Rr?=
 =?iso-2022-jp?B?Mk1wV1pDUVFwdytSWEthck5MVE11RlRiYnNxMkZUd0ZvWWZsMWVwdjdI?=
 =?iso-2022-jp?B?dEpUTFd2Ym8yV1cvWTdZMjIyUUYyeGRkSWxNeEFJWnUvV1B1ekI4ZmlZ?=
 =?iso-2022-jp?B?TVFKeVdVOHZiLzdxY2tCREtNK3JpZ1NaYXBMZ1E5c3JyS2k4RGlwWnYv?=
 =?iso-2022-jp?B?WitQZ0xkYVhhZnppckFuWnpnZ1p1NS93bkhTbnlCM1VGdVp4QU90TmVN?=
 =?iso-2022-jp?B?Y2ozV09DenNGa1VaTDNNbDFZSmJNdENvV0Z5RDlxd2FEVndDUFRxYkMx?=
 =?iso-2022-jp?B?L2g0VGRKcTJ0bFRIWktLaGM5clYzSDdOamVvVHpwL3dwZWRKYnBvd0dw?=
 =?iso-2022-jp?B?U2J5L3RKWVZ6QUxVVVphQkZqSXdMZ1BnajY3a2xPT2RzeHN1cjRnZDFs?=
 =?iso-2022-jp?B?KzVBZGRiKzRLMTVxUXlKQ2FDemxucCthZG4xbXhYQTNVMTNnT0Y2bzNt?=
 =?iso-2022-jp?B?S1FlSVdvYnlsZm5FSWtGdkxvWW5oUVNncHUxaW9Mby9kbEFWUUdId2VI?=
 =?iso-2022-jp?B?ZnBsSXVYaVlWYm9tU1MzakYrNUVUV25MTk1tUDFnVCt3RS9YYlJpelVO?=
 =?iso-2022-jp?B?REova1ZVbnhoWXlGeXNwbW9aMXhqcGRadTRtRXZ0c2xDYVRmL3ZNNXF4?=
 =?iso-2022-jp?B?ZDZTOHovcWlLdm1nSENBVmhVcHAwcG9hTEU3RVBGelFVR0hwQjl0c0Vz?=
 =?iso-2022-jp?B?UlFPNzBkVkxJZE54UStBZ0FGRkRiZGVZM0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706e3393-f0cd-4a4c-c23f-08daf57a6190
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 15:25:19.7570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Pmml6YrOqe0/B+l8EOXxxQcGGXdSBHHs3O+osdFhX4G3OX9a7HzW3tN4LInbCWNWRwvlYaFqoSyweorq7xUoidhDRBI94avciootOiuvBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7818
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jan 2023 15:25:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10347

Hi,

Need help!

I am trying to create gitlab-ci to build isar-cip-core images, but the pipe=
lines are failing due to permission error.

Same thing is working fine in isar-cip-core project CI pipelines,=20
Does it require configuration in the gitlab-runner side?

Here is the simple yaml file I am using

.gitlab-ci.yaml:
-----------------------
image: ghcr.io/siemens/kas/kas-isar:3.1

repro-build:
  script:
    - git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
    - cd isar-cip-core
    - kas build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/targz-img.yml
-----------------------

Error in the pipeline
-----------------
:
[TRUNCATED_OUTPUT]
2023-01-13 15:04:26 - INFO     - | I: Running command: debootstrap --verbos=
e --variant=3Dminbase --include=3Dlocales --arch=3Damd64 --components=3Dmai=
n,contrib,non-free bullseye /builds/cip-playground/reproducible-builds/isar=
-cip-core/build/tmp/work/cip-core-bullseye-amd64/isar-bootstrap-target/1.0-=
r0/rootfs http://deb.debian.org/debian
2023-01-13 15:04:26 - INFO     - | /usr/sbin/debootstrap: 1604: cannot crea=
te /builds/cip-playground/reproducible-builds/isar-cip-core/build/tmp/work/=
cip-core-bullseye-amd64/isar-bootstrap-target/1.0-r0/rootfs/test-dev-null: =
Permission denied
2023-01-13 15:04:26 - INFO     - | E: Cannot install into target '/builds/c=
ip-playground/reproducible-builds/isar-cip-core/build/tmp/work/cip-core-bul=
lseye-amd64/isar-bootstrap-target/1.0-r0/rootfs' mounted with noexec or nod=
ev
2023-01-13 15:04:26 - INFO     - | WARNING: exit code 1 from a shell comman=
d.
[TRUNCATED_OUTPUT]
:
 --------------

Thanks
Venkata.


