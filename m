Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638D8CED635
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 09:03:39 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.67])
 by mx.groups.io with SMTP id smtpd.web10.11761.1728464613422113382
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Oct 2024 02:03:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=pVWgmZs2;
 spf=pass (domain: renesas.com, ip: 40.107.74.67, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkEvJo76RhqHTDieZD+Jts3zmN7WIvhxc4oCw9UexLnAD6RBbY8RR8goWRqMb9TgQKgSRzRsEd+GnCKjHKNllSfLH7uWdJ3QvSf7rigkvSrBfordfen77o0F72AVtF8zcB7ai4hwGusE5bO8fHiMzz1n816QigrXzH3wKHW1KT1y070V6PvOCIG6i7CVUbEprJfDAbPEPiaWcgNP2tdmnNv4mFNm+k+BLSAvivfRRRcSZ7Ri3MkiD/eiiqZGGZNncNi4sv5Q1XcEEZE7FS0d0d9sEk/8qYfJD/NqGtl3TIc15HCVPgYc2Pn2ZXVQNv+NNLsuNBInaDZw8L2s4917Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuR+bqDW60p8ElZuLTrOsOLzSxoLyBXNBjfKLdSYAf0=;
 b=BNGd/8W0fHkUbJ/avknya+GMN8JFwfO1yGSp/rv1Qf4+ZqU8dukj/DmZqK7c5K0kVvjIOTarvm9AAUS0Wz8r+Kkuge8iqjspvWcCwuaU79Vyzg+9OGnKt0X5bbQFb+puvLzEvMv1Nq+RSh2Pw6zeKk4zJntpsjaFD8khPVC1T0w2HAnYQeqjUg6lgicfLnL+DNBtJT3gYJwLF62fvLzDfE6T5eqhtUfOcw3y0xQ8i/VRM3leAFpXxQmzKht6Vd7TZDnR0cgsSRzODlYtWXpqzvBugO8BmUzA7duVJ0B3j3ZdH6jPMijwbdygLXVVBb/zqzG0XoMhImE/B8DH6X0tgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuR+bqDW60p8ElZuLTrOsOLzSxoLyBXNBjfKLdSYAf0=;
 b=pVWgmZs2PM/q77yUsuPDkXu49UtJz/BhuGqWt9aSMHlMSRuJjLd6HXE9JUqanQDOu+DY1Dl6+hoIXSWA05dY6yLGCjjvXuwgDhfEYbyIrUjAqWLKSKXMDPliY8EB1eq6+dPbKXiGYvcAAFvm59xWiWIyDtUHEv+RfZS8MXGIc10=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by TY4PR01MB13332.jpnprd01.prod.outlook.com
 (2603:1096:405:1d8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 09:03:29 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 09:03:29 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: lab-cip-renesas offline
Thread-Topic: lab-cip-renesas offline
Thread-Index: AdsaKgOu1+fH4iYTQ/ipcTRm11rUKQ==
Date: Wed, 9 Oct 2024 09:03:29 +0000
Message-ID: 
 <OS9PR01MB12389085305953A54B65A174FB77F2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|TY4PR01MB13332:EE_
x-ms-office365-filtering-correlation-id: 850affb5-ec8d-47ba-db1c-08dce8413e16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?/xfAMIt4EPz8rVglugVFW5o0HJoB22YOqiJVYyWZ1KWzUS2xgY8y8hx/Z5?=
 =?iso-8859-1?Q?YfWqMDl8Kwjwy6UKOY8obxVNUTcDgX42U0nQ7CPihnbR7KcDrAJAnAou4Z?=
 =?iso-8859-1?Q?AdoXiYUHGkzAf8n7kxGpcWT+rFYuF+6qOAP3X8z+knCkAOHAlFICSxv6/1?=
 =?iso-8859-1?Q?YnUaerEL1B8AeltIs9lZQg2DVeMkmTx158xp/a1MN5tHZj4BbTiUUa0L67?=
 =?iso-8859-1?Q?Ny2SMp5/aqRyi/HKNvzmX94Dwce3X31L0ZRtkdEzVP4hpsKFB2I4fRtJYB?=
 =?iso-8859-1?Q?CtuIq0rcK6h7sTSl0X9BjC0tkB34EHG/H+csHZY1r+l6iH8fFFi4/7WEOl?=
 =?iso-8859-1?Q?vsxKbkyMisFAEFqHs6Q4y70l9rdZ/PW28VkOvt6CYW+Zf91XXjQ8CKhMjl?=
 =?iso-8859-1?Q?tPsc0oODP7epY5TS4GwxMFf12yeyLMywe7CFkhZcJIwyh+FdGn+yJ0lamU?=
 =?iso-8859-1?Q?RkefZkHRxqQKUpE8IePKGvTLLNzw5Vx3b1UxMyqLxDUqofXHcQBS7mFvUU?=
 =?iso-8859-1?Q?j6UFUY1QqpmHkf8lRnLvq4s2fVx6DVuR3FKpaRqxOTLaR5dcLNowug0mWH?=
 =?iso-8859-1?Q?ZFkl+6b+3tvRFS6zTFFrHxqqztW/1iMiln8JN6HwKgW1hifR4KIVDdVzXb?=
 =?iso-8859-1?Q?/6I4/zExMBUdge0ZUEiYWcbpoju66TNcteXfUXaOKnt2TkkDnFzlNGlR2p?=
 =?iso-8859-1?Q?zEshKdd/d0g5X+kOrBJ3We6WAP7dFDqTDqz810IwgDVGOKUV/V/r13Jtay?=
 =?iso-8859-1?Q?VuP6mfbGyXnajYe9EsM1m/U9db2HSin3lw25rqSCEJpMVrSK6Orj+HSwA2?=
 =?iso-8859-1?Q?4wI+TLNI1VZnpO/n/vrsGRegzmnlbnTrcS7lcfcfOOResHQBEsT2GPdOaO?=
 =?iso-8859-1?Q?rlb/F9YXMdwY3PpOCu4HR2lwmLGZ0xl9mslzmIv10UTNi4p0L3JgCWvcFr?=
 =?iso-8859-1?Q?iVgJEm0a1LRRMvADOQo35UnI+PC6Albbo0Lxk7KR84/T4Zo+Sn8n48yQL5?=
 =?iso-8859-1?Q?XWVH0l+nUo3J7L7bxCjQoOIoePm31yvtIdM8qDcOZraJzNT/I5rI6X4o//?=
 =?iso-8859-1?Q?XWNBm+A55jP/8o5amMvQa44V2Wl3uVp7xb1Vwb/1BywepwVHODwsxolJUt?=
 =?iso-8859-1?Q?a8Wug9rc7sQfxKp0uGnDB6P9E/4SN0EA1DS0NnxbDwisGp6XUEhqiVotmU?=
 =?iso-8859-1?Q?GPOF58Gh1pOcVuw39tD922pqdg/rKYiRn4brdEIzkfnHOnrrVsJ/hdc8ad?=
 =?iso-8859-1?Q?lw41/TGlMs3Vafy3v2RqbP+nO0E31Wp/54Qfifd0LstX9uXlsh1nyuwJAM?=
 =?iso-8859-1?Q?M6A6EisyQNbbj2ETv/yZw+vEkkCej7qRX4v1jrjmvEBiVs2hgsKiHyGUTO?=
 =?iso-8859-1?Q?d2rqxmm3ZJZSDCuuomgQRBCeR9pnM8Iw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?JHRB/kPTNvzpTocGMJ81zb32N+DnLrEMbHW7kKIfhwXOCkHH8Xe9XGBZ8H?=
 =?iso-8859-1?Q?aCPup9SfAgZc6IZbJN8CAH5bXdZUJZ8MF96vvaqKmLlWWlmXY6zUnmyreo?=
 =?iso-8859-1?Q?aOi9PdAQ7d/d3dOkOYWx8YBbDAUmjn7NoAdFfzbwaWGAZq1DvAzGkcOWIh?=
 =?iso-8859-1?Q?+jQ2CcL8188fzWSjmuxHhvx3GPfZCv/m665UD1pxbaUEO49BKHjlN0NMQ2?=
 =?iso-8859-1?Q?qB0omB8cewSBC5OvJtoH9ppw6nEfFyJisFpLXLVCwhNCtHhQXzGEgA3+lW?=
 =?iso-8859-1?Q?p6F2qG732Q3sHLKTi3ycir8fzdU6ryZI3CKhU2z+T0dMt8F0hrAYNzVjWL?=
 =?iso-8859-1?Q?BFQbltEJC7UJz+B4w9Yv6qWsAg5khBgkbSAzVsjtlgNf3S2uL9RmBoROoP?=
 =?iso-8859-1?Q?pIOSZ0uNjSQ2KvgIq45jPjbCAsLZEIBglW0ob/ivy5aziisjqkXMKOQoQi?=
 =?iso-8859-1?Q?vwfSgYQ3/xj9MB/I7kXfKBJRSz/zzgRupD/9DPlakEANu75+6sQheyfgxO?=
 =?iso-8859-1?Q?nxdPApZ2RYXm2WQG502HFgksxfgik+0hGmlFlgDpv2OZNaYlcRphZJCcXG?=
 =?iso-8859-1?Q?/PGVB3LWxCH5tnt1/v0Zgy+3IMgs/t7u1c8LeA7a0pgC3PpVRTBrSuyPLP?=
 =?iso-8859-1?Q?WoD5PP2fCMBGcDxB3p7bdmTMWm3ez1OmsVo6lU0+O5LZ4fcG4y4AOOkHjn?=
 =?iso-8859-1?Q?ZXtAnrmWvjMPYdfmOzqumvJQQLMzLdrUzcypPVOWi0Mb+Lv46Pu6IiECB9?=
 =?iso-8859-1?Q?oJCPzVtR7wwi6ZEF4k7RZB+ipa7jdIFi/+Slo324RjdfZfirw7xMZhDSpM?=
 =?iso-8859-1?Q?N7g63BJARg3LrTPas8wjcG16lE1fUtDHinOPGk9u4uf4IdFZhx2ZdoPuP0?=
 =?iso-8859-1?Q?DCWbxX8Xn5PBdHUUVuZ29KIoPfQnHBHgRprpSyjxk2dOqEB4ZYJaMLpHqA?=
 =?iso-8859-1?Q?5pg5QFqkpEHI9yy/vjp6lY1aGzncNpGI8vuvnE4qXtTgEnRDBP8LZowhej?=
 =?iso-8859-1?Q?+InNAXmpv+hxohgLqjPslzW2NJH2EQgT7gQEgS0L/0iyLS1uBf/DQTT9QZ?=
 =?iso-8859-1?Q?7OPPod7JxYt3e15sJIRk7AZYvjwkYJf0PSTZoriCY7dn/YlWs9Dmnj/eUH?=
 =?iso-8859-1?Q?zRZteV6eUR40TfNNahzdPHCoXLgOBstJ7il9am3vTh2VkN+D68eH9j6iMh?=
 =?iso-8859-1?Q?qNHB1mpJ7V7/gAX2t0IoqXHDlCAqPEW+xxncOuVO8jxNf6DcCV6qOyno+l?=
 =?iso-8859-1?Q?gLu8Fdh6Fyx+OOG5hYs+bf8Or1q7W85PlvaXQGoXAXFBE4yyXuylbXClhZ?=
 =?iso-8859-1?Q?tsY3NCxbh0nT311uPS5ZAQhfkrkINgaLPT5rvwZMWZHv7ctTk75z2k9CNJ?=
 =?iso-8859-1?Q?tybnEenDMnitozjQdJ/+B2y6rawhpQXF2EKEk7wpbxsGUZflygUCBnR74Q?=
 =?iso-8859-1?Q?XrdrhFHrsF9Y4SG/X2giCNUeKuEfwTaUn/c9uxNrinoME7QEDe85vR9TOe?=
 =?iso-8859-1?Q?H2nSBncz16HLdHsFHbHmajl2D8nrwnXA9cd1rjr4t+RcBkfUjWeMCUeYpE?=
 =?iso-8859-1?Q?RJb+ARAELeinBIqEx5ABPZxSEEAKQIA7bYOPn3WjNzHLCKfUQaUJdAx1xe?=
 =?iso-8859-1?Q?/Kf1VdG/Ent9SboAVXpHnOmqJE9ryuoznw3vAS/cojpZH3V49xDbcRFA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850affb5-ec8d-47ba-db1c-08dce8413e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 09:03:29.1431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5c1RLzNylGtl3QHJrjfMvXO5Fux1oG/5CagMQEwwgKeT1zMSN9i56gMlez25kET6mYjNp6JbaSNWxXVex6wPEn0zKg+yJtEK98xpzfhII8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13332
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Oct 2024 09:03:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17018

Hi all,

lab-cip-renesas is currently offline (since last night) due to some power i=
ssues.
Hopefully it'll be back online later today or tomorrow.

Sorry for the inconvenience.

Kind regards, Chris


