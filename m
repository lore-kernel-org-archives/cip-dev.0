Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE69F9D0C4
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 11:33:21 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16808.1776166392326667553
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Apr 2026 04:33:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=l0tltkHa;
 spf=pass (domain: renesas.com, ip: 40.107.74.68, mailfrom: chris.brandt@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBOORXWLdDehEQJOylkX0CYYjuR6/NhW8fhbY0czLDQBw2BAxc1XANofniIdOy9dOHxB5AkzyHAoj4TMyLtfNQzpZCxGkHiP3eteB/JQCGmO9mEVLrsHA0kSttzIs2Yv1TO5ciVHJcJXiQ/pkYAmdXLTShIbYhFeueqMQn/JDnwV8CLk8HtaYWWYBknrsOGX7reJsdu1mCx39btC3CqUDmFZc8OK6OrL5QsWV2q62Dj1OFo4Lk0vNmSoyczswd4PeULRhs1xQI14YVkaufCtjBpoH/9dOI2PzKBhx6mKN03xtDwzMBD16P7DiuRZuItq6rKlKp0bQGsSL0hIeTjVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5XkeTQUckCUktP36umzrlasHWtAPk30PfQYR6v2feg=;
 b=DRqr6E6X2s0mvKLm+LAkdFoLQpc/nxb28ngvQXyowgeGSJTlgBgAcwAm6JfpBGUlD8xrAG67M4BfIyqAPQ5iWIv0WoBslGuGATF0Evv85RXeMXXHEERXimoWqPUyUoTzd9H/0LpoFNn9ayOM9I9h3dGWlmNCldINKavRIZUfqVgzk8lOqxFfwhqHg468fRDeAcp7lkQUvrxGF5Hrfn4EO8KPR34zD0+G8YwKi1NYcQOg2Wvc6CRCzwCoQgfJfvn1VmFmzSvZAhTNs+sjyDKUII8CXY+7cVUDhYn7zJOCQfdyK2Ps2DeEEj/oIF3W+qolxg8VKeBJs310DWYIDveXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5XkeTQUckCUktP36umzrlasHWtAPk30PfQYR6v2feg=;
 b=l0tltkHaio99aBy/c8tGop6kqma3LGCBASQEutLOsQixS+ra8uFAC5apX83Tb7zpwYM6+1W7b4KQsc+UGwfONkM+0gmyI7uRkOgM+UKT28wCp76BdEipa2DRGdyndNnUpGKLs/ybM4HLZbmB1qeBkMvUxBvXJz06oLXQd6ZvDE0=
Received: from OS3PR01MB8319.jpnprd01.prod.outlook.com (2603:1096:604:1a2::11)
 by OSCPR01MB12533.jpnprd01.prod.outlook.com (2603:1096:604:326::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 11:33:07 +0000
Received: from OS3PR01MB8319.jpnprd01.prod.outlook.com
 ([fe80::6473:1660:bdc2:c983]) by OS3PR01MB8319.jpnprd01.prod.outlook.com
 ([fe80::6473:1660:bdc2:c983%4]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 11:33:07 +0000
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [PATCH 6.1.y-cip 2/7] drm: renesas: rz-du: Implement MIPI DSI
 host transfers
Thread-Topic: [PATCH 6.1.y-cip 2/7] drm: renesas: rz-du: Implement MIPI DSI
 host transfers
Thread-Index: AQHcy/FsMwUkE21vYk2ctXlh5Kfh+LXeZ6Fg
Date: Tue, 14 Apr 2026 11:33:06 +0000
Message-ID: 
 <OS3PR01MB8319E1A2764C46EC3D8C326E8A252@OS3PR01MB8319.jpnprd01.prod.outlook.com>
References: <20260413171831.3091144-1-chris.brandt@renesas.com>
 <20260413171831.3091144-2-chris.brandt@renesas.com>
 <ad4JUH9p71MPyIlK@duo.ucw.cz>
In-Reply-To: <ad4JUH9p71MPyIlK@duo.ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8319:EE_|OSCPR01MB12533:EE_
x-ms-office365-filtering-correlation-id: b86b1071-bd38-43e1-cc7c-08de9a199954
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 7nvlXAKsaxWzEabHREutkpdC6KUxrj11rx41yL7vD1yMT/Grswk3tWcyikvbONO0UT9sp+Rn/h9xgwsjNxJ4SglNSRZW6Ikur3rplSMp1P2X8n6uQUnH5rhMsy9YaZnP9Pe+OP/wMF3AI+zjI2fQMElcRxOfr6ijFsDT5qA8sf+bUG6WbLt0VaFrtK/aZLOst7c3PEEWnavjpWanjuVpLOCNoRgl/hdd4VC2wyH8rAmWgMnoCZKtcJz+yDBk4kR140epMctgdFDGxr49EP2PiBdNep5HGjGY87H/0F4YXePESt/s1hm5YNDQpqlsW5keP+fKS1JJVJhwec2PrVVpT2x4d2bhIDzrfouydd41MJBaTka12ond0pmKse0xswrlwaISzhmsQS9AxrFbxvy+b9x6uRR8BIAhNP1qc7h1ccqrnnuUVyFKY3zgAD/ZPFHQr0YZywBICRuCZz8AtmU3gWZsiTHsA8KAfucp56onOZn+42+TKu30foOBLIt0/U5pk0aFleQN/UrrEWK1riqsJ65X9r4HWw4aPP1NjURkfVFvih3HasHp5Crut73aUio5odd3q4cydCw1lnsgzXAAOZwOZqETTMFdrIz+JhYtF7B928W3ZG1qJetDTQGjc30OTNLVqSqeob/0EWFt24+VTwRWyWkW9fW7THzcnSWiBtq+y59VYoo82IuyMmdD36YjOA2uZIPmpz1fkVV1qgJAUNi6p7jsd3t8maUK7xIxuvphNJtJ0g7kUsiyOaf2GWkOtXPkq8O6VNsLu+eHtOb3q+fc39/mEQRcLZXoSSsiLBM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8319.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?AB4H/yNa4h5wPfjL6pq24S6JTLQxzWKucL9pmFBnY9WsZ1TT4UhMZVmV+SM4?=
 =?us-ascii?Q?oqfuOJ30VzjFl2j/CQz5zWV3bcR7fBNubPJssT0R5bTyQVFnBpEgBN17gLEp?=
 =?us-ascii?Q?RTsg5UVoHP2HH4mkPejJ+VigHHQtqNrlPanLQSW19GccQielX5PMZsayL6U3?=
 =?us-ascii?Q?fv1dG0Npi5TsMKQi0zkfreGda6H7UbJbm4y9s4ix9aJD1v1WZQXH7HyKQ8jM?=
 =?us-ascii?Q?ag2e28Q5L4/xKDRsa54Zr6mrANmC0p0Ob5oAvsRCa7+qYCBgbxry39bYMDGg?=
 =?us-ascii?Q?OvoSKzuHL+N22FXz6L8Zd1qYuAhgavdsOKmj0pXB8lvbz/SWXTMAXrUcO5Io?=
 =?us-ascii?Q?EkV0hBlRS6MNZi5ngboVGQJLH9h/L/6+zr+r7Xvn/8TiklOeI+tIYyaWvnC3?=
 =?us-ascii?Q?KoNrjfzuhZ8mexr1nGWrzxpqs5LgrCblULMTD4zz333QBcqIGcUBtc6NbE8Z?=
 =?us-ascii?Q?3pxLRWW8/ZtQbte8TQLorDkkLHTqR+ysND9CM/dlRPpVcKArNI4vD3rsQWef?=
 =?us-ascii?Q?kABZLqZHKYqyWksae090+cffiOL2p8//Y7aF085eSW1jzIKhup2JVtyYqTll?=
 =?us-ascii?Q?XZdPJa5K3lTCmrv8ZROduvXDstoZaLucIKGv+RRV8kLPj3vI9w1I5ntasGck?=
 =?us-ascii?Q?swZ3MvFBRxKy0IbM3J8qq3diOapRuOTjrf+onymAlNU0KE78hY6pzjKF5n33?=
 =?us-ascii?Q?UcBF4Yof1hXoRR6tU1irrAANEjJzwtK9UQeYQCgxtAUEyyz8o5zrDyoH1KW6?=
 =?us-ascii?Q?gnt6+G5NoycKOm6FmNspL1ahN8jCBeSCixYovOFMDZxDyD0nbo77ehUEV7xL?=
 =?us-ascii?Q?KyZMOwH/5FRm8emGlGJXWXs2vaS8uIoZtjhodkQlcGVDJCn0DpamlTFBzK68?=
 =?us-ascii?Q?bWnkEoRhojlyn6iuEPMxo6gySlhYm3w/Q3jgb+zJ+jioMFD4mwjfzKVaafPJ?=
 =?us-ascii?Q?+h3nyaiD7l9p4AGMb09DQpgIPb1ntUpk/ImbaRjvY/LCwjkygfTafaQs0FD9?=
 =?us-ascii?Q?HuLJ35x9tv4ytxfEQc/ix1PkM7peT7RWCSvkP9bmIQGjM0QY2lCr8Hhnla07?=
 =?us-ascii?Q?5ZbM6I4/9acqrLo+RjUJ3Bv8041JCNvEaHFW+MCHvCdLajDh8ASakaRe27rR?=
 =?us-ascii?Q?1H7SnU0V4SQUxq7hheERSEQiZTc+S0Zy7T1DSfu33/9gVCbDoRglUzvWcGfv?=
 =?us-ascii?Q?w8lp6yDCJ1hHoslAOi+TiViCfT4a4TXAXt+tTotCgneUP6dP3OIqkJu14BLi?=
 =?us-ascii?Q?TzrgxbMrPZ0cgYfc/7Z2FalzQYUkdgujrr8STXergChQCnFJl2FioNfMItF7?=
 =?us-ascii?Q?Pm3Ft9KVPUWkEzmxyFYQw5NHyW0nXK4KwbePhdqxKMngFyYkUTS/7wOEcnWg?=
 =?us-ascii?Q?RulL8FTAIDE9zqaqddHy/0Y8PB2TTM1IVSEosTbjGa5D1fuyzrCMftCJ/AyP?=
 =?us-ascii?Q?+horasZOJkA51o3/SUnQgsvHCbL21Yoz/1S7nNnt3ymnhjv90M1a0ofLkcBq?=
 =?us-ascii?Q?bDbC5wVYgs6KWC6AloMuwpVcMFN69v8EkFJbxcB8lzMzUCITJpNOuJYuQTk9?=
 =?us-ascii?Q?PZ9Qi62wuiacnnTygcPDEjECyIUrsaGFXSPXYKEjWFm93zi6T2ev+lleXOtH?=
 =?us-ascii?Q?4zHWBl0DUluzOYuR0aUkBOreGxMisKWQfnoPaKMcisCdjOuh8zkIbB8hmTC9?=
 =?us-ascii?Q?uLjOgYXwLUbLm4OgAdEstE0/G5Rgg4X6MFm7Of03AP+zLECpDgeRhxVPus0d?=
 =?us-ascii?Q?wZ/C/l+6YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8319.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86b1071-bd38-43e1-cc7c-08de9a199954
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 11:33:07.0001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IA/E6ssPKnXSSXjo8OMUa3D9+FA6MTRRjfHdb/mYLK+swbFC+soeQMkt1gG9g2TepWt/QvlEUJtoD1fljHQcDFO1745eASqf0zldCSOIS94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12533
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Apr 2026 11:33:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22701

Hi Pavel,

These patches are direct backports from mainline.
I am trying to keep the CIP version as close to the mainline version as pos=
sible.


> > +	if (!(result & RXRSS0R_RXSUC))
> > +		return -EPROTO;
>
> This probably should do dev_err or dev_dbg before returning.

Honestly, we are checking for this error, but I have never seen it actually=
 happen in any system.
But, your point is valid because we are printing out messages for other err=
ors.




> > +	dsi->dcs_buf_virt =3D dma_alloc_coherent(dsi->host.dev, RZG2L_DCS_BUF=
_SIZE,
> > +					       &dsi->dcs_buf_phys, GFP_KERNEL);
> > +	if (!dsi->dcs_buf_virt)
> > +		return -ENOMEM;
> > +
> >  	return 0;
> >
>
> This probably should be { err =3D -ENOMEM; goto err_pm_disable; }

That is a good point.
I wrote that part of the driver for an older version of the kernel a couple=
 years ago before they had those return options.
Then, someone else ported it to the mainline version of the driver and subm=
itted it.
When I reviewed the mainline version, I didn't catch that.
I might push a fix to mainline with CC:stable.


Chris


