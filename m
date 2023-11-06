Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C18C4332F
	for <webhook@archiver.kernel.org>; Mon,  6 Nov 2023 05:38:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.47843.1699249113413156491
 for <cip-dev@lists.cip-project.org>;
 Sun, 05 Nov 2023 21:38:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3A65c4ZT4137645; Mon, 6 Nov 2023 14:38:05 +0900
X-Iguazu-Qid: 2rWgHjD2e5DW4ONQv3
X-Iguazu-QSIG: v=2; s=0; t=1699249084; q=2rWgHjD2e5DW4ONQv3; m=3SM2hpSLh8rKF1C4B/j4TpkFYvyoEHGvQfQXvkSGTGA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 3A65c1TN2110711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 6 Nov 2023 14:38:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwuPGSXs8NatcEDXHhJsNSYdoTKLEYsVuLkC2Eptp9jiwXmWwtl9jn14hhfVuI4Jq54NkK7H0+L2eNmhDftUTDoRTJZD63r1qQkuvbiczWUOzWqa10we8kji2n3eTJhXZJ7lImX2jeKFA2N5yBjR/GLKoRTUb25sB4Z2AMJxdEN6zUuUP92nHdKGxkJ06+A0BuqruLh+EKcKKumcvXZIfZ4+fAWeMAndQz2F5CTIIYvCfS0yGQe6KCSrZKy7ANw8eFRU/0B7gzkErE6QNUrtE7gAgjflAx8bfM1ImR+nanzLsEINIXXgpsy6lBJkvAXvH+8MP6bYyhaqAqhtcftg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArNRe6HHc/fBN24waxi/JmWtedzAL3gdWj6yvvpJBE4=;
 b=TrQTpFU1XbA5DKX7U9VN3e95ctI14iN9wVPWPr0Kjt8leD/tb0KQ93F34GyhmbiDofHoxNjcb8l0kRt/BY1Z/i09aFVNa7QiUhcWyj6AE7GBlJgbFADJkiJy7HxMuyL4HENNFcrvATp1/hykKW7fR3iRjnS9QGMN1IxHdi00qBALsIRmDU0RML0p9jtOSBrc3eMlWMMywqGnoe7Is2iHqq60JWEeCyoKLchpIr3qKACBitE+ww6HLhgFLQjsDL++lZlfrkUssJq6rWnQiYI6i2J4pnKoBC5JS6stkzrqd2qTK0YzHXTmtktf/WNS06HufCANxgMXRrK/z5DVdiMX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.297-cip104
Thread-Topic: [ANNOUNCE] Release v4.19.297-cip104
Thread-Index: AQHaEHNRMuqeOosFH02nUNv2L+H64g==
Date: Mon, 6 Nov 2023 05:37:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245551A6D8EB5251DADC3AD92AAA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYCPR01MB12120:EE_
x-ms-office365-filtering-correlation-id: fe1595c0-d497-4899-e1bd-08dbde8a8943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 iH5LFAQWKkxSlPfThGW7Aq6dUBbrO4tmrOwobPX+PsojtxtgZUE5927os1NcoI/aY4FmhuoY8ZqNCQdpoOeeMG/EGOi0cf+YWbbIeDdrzRlPPj01D8txB0rig0F3hPdL1wUjYti+UFsFjuvqz1Qt4frV5+wP9m0HerDY6auY4op9BStrY3biFz3uiS22wo0QpEobsZWBFHwdgsknmAGNkv7S/gX5lrVUcW9S5iF2QT750ggHgI1hoS/oHaOLy2u1zijmB/WA/EeTjdgHa3Mqo0EMmLJBhEUuthfSsG17kCgWu4sgIqPy0nhqjVxC4jTaolKo4aLOyu392vrT+ZJU8vDiuw/fctKP7Cvc4tddS5A5J4bU9tEhDUKSv34RFtuS4xJTXiTwMIzbTynvz6933PP0UI22WLwrToiESH/mu6Ei+dzNVZ2+LPjQy8DAbQcIF3OmwlBSYv/sh+yM0IQafoji3/lDaktSaAgNG0FA9x230ZHPG0/qpsm6vXKpKGMZA1KjfkJxHoXoa+bs2C4v42bwum+QpUVonzvqpY644O0a2T65chuucREGjl6uBSQhswObl8+9hG0ew7FFM9fOrsApWfsRijLCtsoVgwm+Uqswb7pEOh8fyoqpDxVh8zt7
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(4744005)(33656002)(41300700001)(4326008)(8676002)(8936002)(52536014)(86362001)(38070700009)(5660300002)(38100700002)(55016003)(478600001)(966005)(71200400001)(9686003)(6506007)(7696005)(76116006)(83380400001)(91956017)(66556008)(66446008)(66476007)(66946007)(26005)(122000001)(6916009)(54906003)(64756008)(316002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bjFka0ZuM3R3UXk2RHpsWFdLM1BVL3FuMjZXbk1yT1d5U1ZlazNOOXNh?=
 =?iso-2022-jp?B?T25pWi9XVmpnY2lRYmdKSENYNnF6MjVCN0VBN1pXRVpLK0NzNWpLc0RX?=
 =?iso-2022-jp?B?WHpmVDFqaFd4OTM3SDh5UnhUUVhNQit3YTFhYzgwdmFUTHYwZ1RQNkd4?=
 =?iso-2022-jp?B?alVYS1dkNUlpazJhY01WYldLaFFnYXprbHVxMWVBRHFBNHJzdnpEQXpU?=
 =?iso-2022-jp?B?OC9pakR0N3ViVWVMUFJWYUpQc1ZSQmh0c0FZK2hGajBReFFWRVMvUFVH?=
 =?iso-2022-jp?B?QkNHTmM5TFFFRi94NG5YUTU5Y3dzL2paT0ZLRUdzeXl5THVJS0ZFeGty?=
 =?iso-2022-jp?B?Y0VBSFdwV3plMWhESXlsamVZZXBjYlFxOVB6ekJOM1lvQzlvWmkxdEpY?=
 =?iso-2022-jp?B?RUhYUFVGQXZibExyUlVaOFNqN3lXVDVIb3RXRUgvcVZablo3UVdDSFlM?=
 =?iso-2022-jp?B?cXNNbXl4d2kwSFZvUHY0WXZ2RTAxNDB0YTRPZE1ibFB2cHVhZlRRa3pF?=
 =?iso-2022-jp?B?NzRvaUFlQVBvWDAyVzhENDVtM1ZXZlBuWHNlaXovWjB6K1RHOG1RbkM4?=
 =?iso-2022-jp?B?MitrYmpiUjBWNFB5SXdWTlM3dzlwNnVoa1hsU0l0bHNXZExwdU5OM2hV?=
 =?iso-2022-jp?B?RnlLZUhSWkF6ZC9NemtMTEczZnUrRVpzemplbFVjVjZSUWFnNzZGVmxD?=
 =?iso-2022-jp?B?bTJwOC9DTWdGMHYxSndHbm5XTStCY3hKdm9ITzcxS29Tc2ltWFRsTDhJ?=
 =?iso-2022-jp?B?VzZNbkp4SmtGUVhac3dIRkRkOUFPQjJQYTBaZDZuRGtuYnRRcms1NU01?=
 =?iso-2022-jp?B?SStYaGxrQUZFcUdEU3pxQ29aYnZrMTFWeitIK2F5WTFna0JJdUZzeHVy?=
 =?iso-2022-jp?B?eW1wNEFYVjZ6MXNJZEpNZXZ4SzVBdmpqeWRHU0hQb2NadlRtOXVmd0Vv?=
 =?iso-2022-jp?B?cXQwSGl0NFViNGZDMkk5UGxnTVp4SWFPZU90YmhLWlVzcWFjZHErek1r?=
 =?iso-2022-jp?B?a3pxTzVhUEVDTkVwRVN1Rk5XdERjYndTRVNmMUExYWx5NWpnNmFJdEtM?=
 =?iso-2022-jp?B?ekt0a2FxVC9RWDcyRU1lczlmTCtodWV5VXc1d3FsSkdQbCswSkJERGlU?=
 =?iso-2022-jp?B?UVl2UTFHVTZ4SUFVU3YzZWFQK0wraHhQenA4Z1I5NUNRM0RHZ0thTEJD?=
 =?iso-2022-jp?B?UDFPRTQwc3BSMjJJUkoyRUtEWUFBMkVOOGw1V2N3RThoWisxNjFmc3Z4?=
 =?iso-2022-jp?B?N0lyN3ZsMFZRdm1GNUJsTXhndlIzRzRNUU5zazkwN05vZ01VSVpaOGx3?=
 =?iso-2022-jp?B?c3JheTlZR1VJNW1hcm1wOXRHbWtFY0tWQUhQdEZtTDhzQnVtNFBVSHF6?=
 =?iso-2022-jp?B?RWJrZldRQSt4OWNic3lKMWNsUVFLQ2xVc1p3YTRsc3ZtYnVYUXRwRFF2?=
 =?iso-2022-jp?B?am4wT3h4dWtJUGJHa1RHZ0xpRCtDaXJaM0g0Ym1BeU56eXNFdHU5VVU2?=
 =?iso-2022-jp?B?QlYrMFg4bEw1dU5GeXpKYTZYWE9Xc29PSmd2ZWFrOEhmQWVhODVueEtN?=
 =?iso-2022-jp?B?blpwaVpLdzZWL292QjlmYlQzcUhuN3Q2djhRZDdMTk12YzVUSWQ0RzJ1?=
 =?iso-2022-jp?B?WG4vVHNvbzEvQWtiQzdUSTdlazFXZ3FqTVRMM01UblAvWFZhSkVSR0R2?=
 =?iso-2022-jp?B?M2Vod2xBaW5DazRHNW1lVHl2dEVGcEkzaXlKSnJnUlZsTzhrbGFPVUx2?=
 =?iso-2022-jp?B?b0VQeTZaY2lQSmNmd09iL0t4clE2SDM4MTRkYmJyQnE4L1VUOFJkT2dD?=
 =?iso-2022-jp?B?Y25tYis0eTJ3N2tqUzFoZnMwR3V0R0VoTXR4VVFPRGNrQWU3NDRaeDRV?=
 =?iso-2022-jp?B?N2M5cXBYWCtpaWdZa2xiR3V4dEtCY1FJdVg4SkZQV1UzZEVZY05vQzZJ?=
 =?iso-2022-jp?B?L1FpTElaMEZqUkRjSDhjSGhVZEpEdjZQbytvTzFLaEQ2cHhMcFB3K0Nv?=
 =?iso-2022-jp?B?UWl2SHVub0VlZkJtWTd5SVZ1YTRMQ2VPVkRtV1RTODF6em5ZUklhWFAx?=
 =?iso-2022-jp?B?OVhyTDBicUlLVStONFl5MVZrVHFlMERVYjFaOEpqYXEvZFV5bjJxY25C?=
 =?iso-2022-jp?B?Y1dQMDB0WkZSeWl1bkY5bHRvNUptMGF5RUdnZ2NGRnkxS3BYc3E4cERr?=
 =?iso-2022-jp?B?RDBwd243VFlFNEVYbzV2b3JnMi8rVDJERHA3V0dMUnNHZVkxTlVuZm5W?=
 =?iso-2022-jp?B?b3lxTGFsS2dIbWh2MnJUZlMycDBiVjFNVXF1SXZiTjgrZXByemtvOGF5?=
 =?iso-2022-jp?B?Z2pPc21Ydldvb21EVFc4ZHhWcU1GbXV6T0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1595c0-d497-4899-e1bd-08dbde8a8943
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 05:37:59.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkuexuLn4EZ23VrcXi+wZgx8qyFHVQo2F44zmS5TPDC+PXt/8X1NAN2wYhI+FBconABF6ML8xYRYK3nDsROIJHKnsOc4A+RthwJr3MPPjfk59xmaq9ANpIfyMgZ8UpBw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12120
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Nov 2023 05:38:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13535

Hi all,=0A=
=0A=
CIP kernel team has released Linux kernel v4.19.297-cip104.=0A=
The linux-4.19.y-cip tree has been updated base version from v4.19.295 to=
=0A=
v4.19.297,=0A=
=0A=
You can get this release via the git tree at:=0A=
=0A=
  v4.19.297-cip104:=0A=
    repository:=0A=
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=0A=
    branch:=0A=
      linux-4.19.y-cip=0A=
    commit hash:=0A=
      1de13c21df07c83dd4c4d46225a226e5cd9b1a13=0A=
    Fixed CVEs:=0A=
      CVE-2023-31085: BUG: divide error in ubi_attach_mtd_dev=0A=
      CVE-2023-34324: xen/events: replace evtchn_rwlock with RCU=0A=
      CVE-2023-42754: null pointer dereference in Linux kernel ipv4 stack=
=0A=
      CVE-2023-5717: perf: Disallow mis-matched inherited group reads=0A=
    added commits:=0A=
      CIP: Bump version suffix to -cip104 after merge from stable=0A=
=0A=
Best regards,=0A=
   Nobuhiro=0A=


