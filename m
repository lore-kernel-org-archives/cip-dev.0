Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA4EC05027
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 08:55:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.9878.1676019322015784531
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Feb 2023 00:55:22 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 31A8t0vd014973; Fri, 10 Feb 2023 17:55:00 +0900
X-Iguazu-Qid: 34tKVCYlaP58eB8ZhR
X-Iguazu-QSIG: v=2; s=0; t=1676019300; q=34tKVCYlaP58eB8ZhR; m=vLyWYm82ZqiUTQDtJ4TnFAYyN+2U6+e8Y223hwIoioI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 31A8swCt039407
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 10 Feb 2023 17:54:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1bpNpWSKyGUHKe3r8EZqFynTk2lUR/KqaUIfL+XBL/n1D9YAYd1JTRQBv62QMhusF1Br2FvJlkXnsvBNhY9JZYbeaHeO2fqcz7BJ4HHdzJqmi7QKmMISiaHPSh/6MxpqHz2v3TWKSZUL1edKznfojwIWe5xQvDbMbDOofOMwwE4XCp4Rd7Yt9+HJMurX3um+lYBiO6UVss3L0rsBhWGeL6RDT4gQU5PbCaiTx5L/ZNplJbjM8JmMVDDoBaW0ffPMc+qEm9UQQlYoG9GNxcvubkhXGDypEpMQvoJgfGHskOy3ZsugX9efe2YI4hkbyWvOAwsYYJdFAVm9X+3MsNfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEFx/RbncYs14ecVtwCv1F0nXOWQGUNCgCFWQxQlN2c=;
 b=d+hRocX3ZRVRTBiZ/01kSystm8gCURi4P3thQ4SjEA70a2ukD1m09UCwHiXrrF5u6JH8E6AASUelyMLMKGbLqZ3ZtQbPm5odH81p7Xo+IxKNVBOV7bb5rXOA7U+bDwJQZM8OhBd5kNBoIgK0SlEZ9iNa9lM7+3ubbKMRhEX+DQtIJRmKNGAmFqCOMuaE2O2HWjNH9Z0fMCBpkKGuUOW6MLKismddTo9k/i8vmpSf1YUXotvS+gtAXn6iAYIfXfQqKOQCBtMlkULYKmjJyE39kpLJxrihIVHUOR1WJaU2t/VYL05Lv9qGB0ow1JeH+fXPNFBnvB/fFFfJ8d+4nQ/qBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>, <jan.kiszka@siemens.com>,
        <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.272-cip91 and v5.10.167-cip26
Thread-Topic: [ANNOUNCE] Release v4.19.272-cip91 and v5.10.167-cip26
Thread-Index: Adk9LT3taIq+IYG9QeaL7ZnnWaiTJQ==
Date: Fri, 10 Feb 2023 08:54:55 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB942099A1C577FF2F4C45372292DE9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB9546:EE_
x-ms-office365-filtering-correlation-id: 1f74c037-fe61-4fe1-1849-08db0b447b4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: emAOlLdKCBWTO542H1in7oQHo4MJl2I3pS+w75tdcsAk1yPvJP9GGHkZs/+UEalZwzsZy03nrhJw3REcjlXaxeLrRvasVqtlz3YEOPqgZn2DPmKs7kz3/16stLqbhJXUuuRTOspe2l2Y4TZemuphzT+o8pTeuk5+5TtcJ8RsUnDvNpQpwdiL19z/6pxFg0mjhyDsHU539/guUJRjy7S206LmWPYOMO3HbwfguuQcAr9IBo9C8NfNFETSPNCAk6G/oNJ9zpCsQV0Yi+LWITIXqlLVF/7VegqqvXGL4g7Ae08vVx870ZdiVHOBZFl8EsxFlgeK8NO86iK6mKIgCKIwofvG3uWvUAs+iQV8yqMZYA77ZGszZnXYw0Mgo5D+ACOMQb6lNpSGBQwV/YnDRddOn7bq4NhnGY//HWunme4lJPWOudwTV/MtuUIi52TDbh69NTKyiJRWuaAdvYUhztSX/wm0ZkQ4nJCZATsH11KhB60egiqD8bTPBuAfvUSieDXwoe+5unXZ7iXtaLLWqM92hUX0aa7HsNT7jlsmJo7lQ56M4ZMLk0/tuMw+A5fsSREbgZI31Ls8iQyjAHF1T3FdUdjqwfAihlM/4vEU0NdRb+FVMDXyxFqRd3Ny2Fs8biVhdOCe/yTBNyK0tFIReJ5jceXs0lgjJNcnCjg4Cn3ce9rC8zYLpE/tmM3vR7rpkEQ5ynx6MSLBFkcbgfKv/l5/LxeWc2mHNAnl4Z5CMyYlsyA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199018)(7696005)(71200400001)(26005)(86362001)(478600001)(966005)(55016003)(8936002)(52536014)(186003)(55236004)(9686003)(6506007)(54906003)(66476007)(4326008)(8676002)(64756008)(66446008)(6916009)(33656002)(38100700002)(76116006)(66946007)(41300700001)(66556008)(83380400001)(122000001)(2906002)(4744005)(316002)(38070700005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?eDFJQTgzWDZGQzBCaGk5WGpiejZseGlSeTRWWHpJZFNsN1NHejc1Uk4v?=
 =?iso-2022-jp?B?WlgrZnczK1FWQXlQcnFrdUxoRTNYb0xmbWp4MW1MOUVCL1lOVXA4R01z?=
 =?iso-2022-jp?B?RlNvOElOeGQzVUhTMkdZWUx1cVdaMEZUVnpwU2xHWWF5bnhCVndHVzVN?=
 =?iso-2022-jp?B?WFRKMGlocEFSbXhDeUd6anExQWE0ZGlhQnRjR2hORXJMYzA1bDhmNExl?=
 =?iso-2022-jp?B?ektoVTJnK1N1Z05FUlV6UXZlRitKaGFLVFZZRThqVWNmZ0w3YnZPUDJI?=
 =?iso-2022-jp?B?MEZmTFpuNmk0Z0UyZ0FFMlNpNFlvWFFVYlpFZGVGRlpGWlBSK01FUFpx?=
 =?iso-2022-jp?B?eG1yYm4wUHVpUlNEOUtpbmd6L0RRZ3JpNGFqNGY4UmdWVURRV0lQaUU1?=
 =?iso-2022-jp?B?S2xvZWlYb1ZVZmV6aDZtZ0pEcXp6WmdSR1FYV0sySUNFZ0wwT3NLMm9V?=
 =?iso-2022-jp?B?TERweUdac2ZPOFdLdXdPbk55TkR3b0hOQ1RVTTUyYjhQWUttUC92dGhw?=
 =?iso-2022-jp?B?QkhHVEdsVlNTY2F2ZEM2R0lNRlN1Z0hmU0NjL2dhcDVNL2FYcStKUjNU?=
 =?iso-2022-jp?B?MUFYNUZHbWRXRjAxTnNlWEhKdk9RWWJBQW41V2hHUjhyQjRiNEJLYlc0?=
 =?iso-2022-jp?B?SmxtN2JKYVpFYzYwcGxRSUdTeU41RWkvd3VPbHN0LzJmcVkyLzdaNTRK?=
 =?iso-2022-jp?B?YndNb1VJejFKd3BhYmtmcmNveTAwMnFxYngvUW83d2VvTEltVm1US3NH?=
 =?iso-2022-jp?B?VDM0WlAxUDcrVUNmMDlIT3RJdS91R1FpaHRiRG9GSmRiU3ozdGFJbzFX?=
 =?iso-2022-jp?B?NHRydzhkeUdjZ1dFOEJZU3ZTQ2Z4YVU5RXR0amU1T05GOUVoL1BzQ3Zp?=
 =?iso-2022-jp?B?bWZ6cTNlWEE1QmJJRkFXVnNjcEd2M0VQRjBraXo1TVFiQlNXNzY2eDZX?=
 =?iso-2022-jp?B?TDd0SDAxVWVCN1VjckxINTZwbkpsOXFVSkd4V3cxS3lEUUg3cndtVWVH?=
 =?iso-2022-jp?B?SHg4ZC9YeUloVFBISTdkd3MxRWdBZXlaM1A1QXJyeGMyVk5wcEJJQStu?=
 =?iso-2022-jp?B?YVhZcnBINUpmZW45bE5qVmh4TEl2WjFYajhrcFhORUJ6SkRWMzQ1cGFT?=
 =?iso-2022-jp?B?Y21QM0k0NGZkNzA0VEJpaENybnF2aERMbVhBQVpkekpGMjhSaEMwVTFr?=
 =?iso-2022-jp?B?SlI1RjNDRmlBM1E2V2NxT3Y2Rmh6MlNCWEZON25KUUprOGZjYjFqa3dZ?=
 =?iso-2022-jp?B?Tk5nWnVTb0l6ZksvdzJFL2JROWRYZDhvSlVoSTVqTmpZS000MTN6RytY?=
 =?iso-2022-jp?B?a0NkQVN0YVEzSDBlNzdZWUFqNjltZGpDRzl4WEJPOWlxc0VoWUppTis1?=
 =?iso-2022-jp?B?VXZpcnA2dEpqb2p4eW9YK0NtRzFSckVOaVdpS0diTHh4ajA4cTN5NlRz?=
 =?iso-2022-jp?B?b2RJazZlYUU5UExOZTB4THdCdnI3eDNFVUtZb3dOWmhrVGl2cDJIQURV?=
 =?iso-2022-jp?B?LzFVNTFlTnlqbTd0Y1lZZVAvL05GcVJKUm5hTkNqa2NPZUdwbEl5d25m?=
 =?iso-2022-jp?B?Zk5LM2lFMFBnMWQxWmt6YTJBdDBNTEdKZ0I0aXVKTy9TblZnTmhud3hj?=
 =?iso-2022-jp?B?WXMwMDJlTDcxeWlBeEgxTk9kTjVZUFUvcmh0S3pxa0tOQTBEaW5TbU9z?=
 =?iso-2022-jp?B?cTJJNTZTV0VHVEprUEVkM3g5NlROWnJNc0RGQkxQbTVjM1BUUW04Tjdr?=
 =?iso-2022-jp?B?OE9rRzc0ZkZqS2FiRFMxRnlFRWd2TDYzVXplenc0a3FMYmRlL255MklW?=
 =?iso-2022-jp?B?VEhLd040ZDE5NmV1Q1FrT1BCMVlncFJTd2FBYStLOUdmdnFNd21Kc2hr?=
 =?iso-2022-jp?B?Q0hsMy8vNXVPZkU5WXFYTUU3MTFuOFc2ZFNuQmJFVE4xWGExWHNwZ1ZN?=
 =?iso-2022-jp?B?cHVYcEo5czRsZE5uaXYyRXZ0dFArbzFhSDFvRGdtdDM0RDN5RlJ5YWx0?=
 =?iso-2022-jp?B?QUR0RVFnaVJyMSs1d0g2eFAyUXRCOEYvdjdqem1XT1F6YlhrUGhRZmdR?=
 =?iso-2022-jp?B?V0JtRUhXNkgrKy9pM3FlalQ0cTFLSDZORnlBOEJrQTRhUVVZUUdrQ094?=
 =?iso-2022-jp?B?S1ZTbm1wMWZTSGN3V0tBcjhYUGl1bHlSNFQxUmlQcWpPNExpeWY0YXpU?=
 =?iso-2022-jp?B?ZGg2Yi9XeWxTQnhEOEtwc25YUlRmVE1BTm5VUWU1Nm9SQ296V3IwOVR6?=
 =?iso-2022-jp?B?ZWg5Vngya1ZkOEZOaGRFTHlRMFYvSmM0TkNQZFJiVjBnV2ZvWk5YV0pJ?=
 =?iso-2022-jp?B?RmxHODgxTUxuYTlyRUZjWlpKK3Y1c0J5Q3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f74c037-fe61-4fe1-1849-08db0b447b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 08:54:55.7363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clpZs7a+nQGRc8+dXoZplsrVV9p7tWrzZV3vDHhRZIG6ZHIONgx7U/6bIqWyueDpn4mPDj7SV339PR8mrshxSI6p0KbEp77QMS814VP97ktiGB/3sUDmogko5S9Z/KvH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9546
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 08:55:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10635

Hi all,

CIP kernel team has released Linux kernel v4.19.272-cip91 and v5.10.167-cip=
26.
The linux-4.19.y-cip tree has been updated base version from v4.19.271 to a=
nd the linux-5.10.y-cip tree has been updated base version from v5.10.165 t=
o v5.10.167.

You can get this release via the git tree at:

  v4.19.272-cip91:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      a308535fd0f82d23c6acc4bb20c69066ca01bdd6
    Fixed CVEs:
      CVE-2023-23559: rndis_wlan: Prevent buffer overflow in rndis_query_oi=
d
    added commits:
      CIP: Bump version suffix to -cip91 after merge from stable

  v5.10.167-cip26:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      dd0dd3e572fd82c1c232ad1f089ca628d7dc16de
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip26 after merge from stable

Best regards,
   Nobuhiro


