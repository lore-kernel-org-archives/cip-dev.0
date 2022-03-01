Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A743DC433F5
	for <webhook@archiver.kernel.org>; Tue,  1 Mar 2022 07:43:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.5828.1646120579480804566
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Feb 2022 23:43:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 2217gaav007429;
 Tue, 1 Mar 2022 16:42:37 +0900
X-Iguazu-Qid: 2wGrI6s8cKEXQnz2Fo
X-Iguazu-QSIG: v=2; s=0; t=1646120556; q=2wGrI6s8cKEXQnz2Fo;
 m=tPmxVBHLEuBhuloy9HQelr1YWN97VlRyFXRBLTbiSx8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 2217gX3w011283
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 1 Mar 2022 16:42:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZT0asMkZPL39nZiI1u+g9DCDglIYTsLC7IhC8P5YfgqGZ1jHzRbxw/Owkmtm7SE/NKeP7O/TdTh3LEOtE2mV0I4dtFKeW+6E9fNNpz3TiuLxOq619nu+dDKcqKMbj80W3u7Ry+LYebnp8sm7WTCAcIDii6pcMJVFg3eaBvIWdGLwUuQO+TWH6tOc3JuFGj9MYlA3UbDavqHz6PwDGs+P9ZssJlu6PUvkRBwkKdinZyunHZyo0S94S5o4kX5HozghqKxJe2PKqcn545U8M3zluyqr0XNlRwcVdC6dDpTymeGl8eqD1SneTQ9nsN/wiBQ0n2spsmCcWYV9saaWooRhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3i6qX3EWBfiyYkcL9BmHBf6qaHuki3E96Rik/38/ck=;
 b=EsOoBv/ok+efB0ESWfiJS4qTOEPLtRDzDZpa5J4x1vLCyVxuipi/IFMQHRtEc3kj8TOqIWDbRyaYzxiRTbvLVdwTmYGbhuSByDCTemBkz8CxNKr8OW8Ia4mL5IzHLCXCGYdHGjD8Koy5Xb017V/Av+JTA7Da9ZfZvPEdmqWWhXVzrFNoW3N7O08xQNHOKsDtWg58eT4BlMYgWkYQxU7qupakjzfZbmUfg3n/eIWRBk340SMqZtBOYLu46gUBhrQZQ/ytnw7LrFhbCbQ7lcaHsNnjRLL2zFaAnQJdsD0SucAYyb4/oMl2geVX7tvAQ9PXCh41ZS2FiZnUpXsCFzmAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>, <uli@fpond.eu>,
        <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.231-cip68
Thread-Topic: [ANNOUNCE] Release v4.19.231-cip68
Thread-Index: AdgtP8yKZ1II/26MQ9S9N/r/t4yleA==
Date: Tue, 1 Mar 2022 07:42:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB6252EBFBECFC83DCA2B8A46892029@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc45be5d-e673-49a9-bde5-08d9fb5707c8
x-ms-traffictypediagnostic: OSBPR01MB1462:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB1462BA8425CB7931B886277692029@OSBPR01MB1462.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 z5kxF16ldNwMrzFbdO0/W4BRk+mkvvR74kJxYiK/xqKa5ryr7l/ZdcWf9vy7677Dn5UThZKLwlynm/iVhQnE6x0FrmQmiMJqURvjxvABxmmDxyvMgxBP5l7i8s1ZVS4XxlyIim+YRM3dZmh5NSWEB7lGVu0jtIFXMWvOsp/Ujk4vVOY1ycwbGnQDKQAN/Q0jLOtqddO8BQezzoVlMTmmb3MHO7lXVfFR9qak8vrFdlbdK903Gz/ErtloVSfhckHwg9VC5FGNBvrvTy1JrFVzeHJ7SPQcqf/exClOeIBx6XBhT/6g+4fsaPmgF6o4kU30DVFkamJ69xJmDoR2UdVxE5/8pMFQI8dj4ndXROOfw9dJMBPuWHzUXcvHeEorwmsBJCKNBDwhg4bX9+eXOfF3BgcJcultTU2awPXO2N3JcokNEYAhTrovKPmaTDNxD+pEkCHGHPSyxjDAS6U4QW+r/+ixyy30UU1Z3J2VuGPcpD/GSb97pvUz2DN/jhDhxdcOoimm/+q4s+3VMUZD11S1yvZe7nuDRehzsFpZkEU3MAahync7FzHTRsa6WYrwEuTXdlPnEeU2NEmMeNdRQ4dsdFxq1rc4YFNhmwy8eov8Rz/MWNvMzBSltb0Yb55mf4l9XwZ6xeJ3FikT1DZKbHyrJMrC6ZZsZsjXa8j51+T+WwreNaWqx4+dHS00cuiTwrNf3dUCjiejjn8H81/Ht91vXzWPU9gtnt1SwXRLsJnnoQGhdtwJjJN9HeSs3hx6EmhvhCVAhoTlGZuChromcNOTc3EOCVB9WX2w9ZVUvGYaF3I=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6916009)(54906003)(7696005)(6506007)(55236004)(966005)(71200400001)(508600001)(122000001)(66946007)(316002)(66556008)(66476007)(76116006)(64756008)(38100700002)(66446008)(2906002)(4744005)(186003)(4326008)(8676002)(83380400001)(55016003)(9686003)(8936002)(5660300002)(86362001)(38070700005)(52536014)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OWJZQVJzNis2NEdkRkYwNUNZeGtHL05ock9pN0I4QVh2Slo4YWVxQmMw?=
 =?iso-2022-jp?B?WHVKcHYvZG92V2Q4NXVWWHd0SXJicEN4NEt4ZjllbTdFVHpETGdid0xO?=
 =?iso-2022-jp?B?TUgwYU1LNW54akFEQkZQQk5RU2tYRzBQeEp2Wi9KUXppWDFYVnljajVo?=
 =?iso-2022-jp?B?MGJDRjJ6L01FSDZpeGQ2ZGlmYngrbCtUUGRsayswQ21JdS9QY0NTYndj?=
 =?iso-2022-jp?B?OVVLaS9oV1luSm01NWpTU2dMeTF6YXRBanU2L3grQ1pxQmJ4ZEFoVlJ2?=
 =?iso-2022-jp?B?L0dJUENCazIvU3NzSnVEZEdCRDBlamdYSWxFSncvaWRqS1MwMkswWENo?=
 =?iso-2022-jp?B?YVBMeTRrZ3RyWFludFFaeW5rOXkvc3h1T1cyM0lqdENzUHhWZlFqQ3Qx?=
 =?iso-2022-jp?B?a2QySllYWEhmMlJHdDJzejg3cmQwVGNpbnRqWlhQTTFEVTFFNmUwZi9R?=
 =?iso-2022-jp?B?UHAwZ251N09nM2NGcWx0WDcySTdqejBPemtRRGNVSUYvSzFKZHpXb0JX?=
 =?iso-2022-jp?B?QTFZNGliOC9aQkpGUlNMZWdnVjhmUDJ2aThXemtSekdwR1dxaVR0SVhM?=
 =?iso-2022-jp?B?QVhodGxxNTMxWmJ6RDc3R1dpbU9EcjFJUTB0RmU0Zkt0L21YZWNkL21P?=
 =?iso-2022-jp?B?RGMzb0lRbmM5TXptbzlQTWowZmZkOUovcnJTeURrTE9tZ29IemYwUTdp?=
 =?iso-2022-jp?B?NHpiSUFaVUI5T0JRamNIRDRJMEJRMU55V0x2VG1ZWWJObCt5bmxOS3FG?=
 =?iso-2022-jp?B?a05kekFrcFFTNlhEWVVtaFFZejBRSDF6dmRSdTBvdHEzREwvM05rT3pO?=
 =?iso-2022-jp?B?c2tXL0FKNDhEMGZMeS9xNnAxS0psWVl3dEt0a0laQlB0QjlFblpMeU0v?=
 =?iso-2022-jp?B?SkllcnFKMjljYURGUEJUZ2J4QzlKQVltc3lEV3ZNc0E0N0tiM3dMMk1o?=
 =?iso-2022-jp?B?UDJBZ3lkeGhyb1FwQkIwWFpQbi82RlMrVXE2YmRLQ2hnbk9ON0lrZExP?=
 =?iso-2022-jp?B?SWhvazNaQ1VOc0FubVUvYXEvdzFDLzlEbS9QY1diVmFrUU9ZbFNnVkhH?=
 =?iso-2022-jp?B?VjNLY21oQkR4ZFJDbEVXOTJaQUg5bDFTcmJTdHVRVitnSE5Xek5oRzJt?=
 =?iso-2022-jp?B?cm9HSCtrNEhNVVNHYjRYdFVUbnFITW1Rb0tGQUNyTmdkS2tySGV2Rll4?=
 =?iso-2022-jp?B?ZG8zN3BNbFY0cnFQbjhHbUl1TDVvWmc2WkpZWnBaTVh6Z3hnNy8xeDlE?=
 =?iso-2022-jp?B?R2JDT1pOOU80ODNFYnpmdXhUY2d1SE1pTUdvdWhpaE1ZY2czK0lJYjdl?=
 =?iso-2022-jp?B?dVpMZzBDOFZESkFwemRrL3JxM1lFUjZlRG5UcU9vRW1MQ0NCbEhTbGdU?=
 =?iso-2022-jp?B?SVpZMmFWVUJNQTcvTm5xYm9ycENHdmlKSzdJTzZRWXdsVG9KNW1BbitN?=
 =?iso-2022-jp?B?bFpLbUNKaC9nSm83d21lL0d4UzJMNER0SDV1QUVNSjlGczBORURBYVY1?=
 =?iso-2022-jp?B?b2dIWEgyQkJTNDRkb0V0NjBsM09RQzhRUUVKaFBBMmZOZ0NuWFl3VmNV?=
 =?iso-2022-jp?B?SG84cTZRMTN5WmZNU2NUbkg5eUZIQUNvNWp2anl0ZTgyUnBnZ0hWMjJp?=
 =?iso-2022-jp?B?UnR0c0Y0b1lZU1ZzelNEK1A4MXM0dVZVL3I5cy9vUlhBbG9XTWw5Wlky?=
 =?iso-2022-jp?B?RzFUWklIbkdaL2c4ek5HU3VScncvbUsySDVWMjh5aFF3QUp2ck82ZVBx?=
 =?iso-2022-jp?B?Qm9RL0ZOb0VuZXdFcCt4MGJqQkg1Q2ROSlhBSUhoR2wwNUdseWhhUTFZ?=
 =?iso-2022-jp?B?WHlFWVdiMHhjQlRhTlh0c0hqZ25udnVoZ0RoYTlaWGhNb0JWbDhVcXpC?=
 =?iso-2022-jp?B?Wm9zNkcyWWlBTzRnZ1RURmtEdlhBQjVCdzNlL3VhRldhVmh4Z0VkVVRQ?=
 =?iso-2022-jp?B?Y1FSVjZ3ZWFMR0wxUldpRnJoUVlVL0ZnMHlzOGdTNSt2ZGhZWTQvMGV4?=
 =?iso-2022-jp?B?c29xZWZmWVpoblFrS096VWNWTGdUZ1oyMTlTOGlUMjJCN2d3bzZYNlkx?=
 =?iso-2022-jp?B?YTVzalV4dHlXN3cxdUFiQ21vUnNxNm1XKzdmWmRqRmlnd3JJdTl1S0Nt?=
 =?iso-2022-jp?B?cUFWN05KYlZiM0E5Nlhhdm1pSzg1V2ljcjFMWERzM0RCRyttbnk5ZERE?=
 =?iso-2022-jp?B?ODgvaVZUbmxDV1ZpazNlRnp6U1E0VzNGQTJJOGduNnN0TmVOak5xbXp4?=
 =?iso-2022-jp?B?QjdGL1ZmdDBwRWJLYnJLOVBtVkIvclRsWmViRXFXVEx4M3dJaGlVVXVL?=
 =?iso-2022-jp?B?MWZ5aXRSdmFNT3FzT3prWUgvbVhDU2ZpWmRMTnJTQ2UvOWJXUmdKTW84?=
 =?iso-2022-jp?B?L0Y1UVU5cUV0cE1FZXB3NTVHNVkwUjJpckRtd1NndG1EWXpCQ0lLb2Vr?=
 =?iso-2022-jp?B?VGlpQkQvOWRkU3p6Q0ROeG0rMzhjeW9aWXlEN2xDVHdsck94c1l6eEVy?=
 =?iso-2022-jp?B?MTB5YmtL?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 dc45be5d-e673-49a9-bde5-08d9fb5707c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 07:42:26.0177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 E2NW1xFr1/2mpc6MUuGWtnGDlzgcCOKW+AAGBwLpHFziUoIqYC+pMzBzDvzXlJo4S625Bk+yy/v1m96h9Q1jAA1YIAhd4kO5+tWBRCfk/q2bHBkjFSW7itnc9a/brQdz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1462
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Mar 2022 07:43:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7643

Hi,

CIP kernel team has released Linux kernel v4.19.231-cip68.
The linux-4.19.y-cip tree has been updated base version from v4.19.229 to v=
4.19.231.

You can get this release via the git tree at:

  v4.19.231-cip68:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      c7477548dcf8c653b00e361f7a724f0b94e7d372
   Fixed CVEs:
      - CVE-2022-25375: usb: gadget: rndis: check size of RNDIS_MSG_SET com=
mand
      - CVE-2022-25258: USB: gadget: validate interface OS descriptor reque=
sts
    added commits:
      CIP: Bump version suffix to -cip68 after merge from stable

Best regards,
   Nobuhiro


