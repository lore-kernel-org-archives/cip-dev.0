Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF8CE65D36
	for <webhook@archiver.kernel.org>; Fri, 22 Nov 2024 09:21:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.20739.1732267299740279335
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Nov 2024 01:21:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=WFglxKyM;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1732267276;x=1733476876;bh=xY
	UDhV+xvYCWmp2OH1/sP1gd25DX5wJB5Vd/rm5wOxE=;b=WFglxKyMpIAEqGB19UGsGeklGGeazbZ6
	8PV66i7Xjrb7RTc8MSJD1RXt6gyK/pgehMdzLM7aKy2YgIUGuXuR8DwA0Wl5P3wPk3Q/C/uU7CxCi
	FebMNaD9lduAtqCtwIxiXY/QxgrOFU0vVykPbOJpVTgs8WCZw36zo2SkRnUcZUBKKQWVukDy1bip/
	rUYi90kaT7Bl0fyG7TrZ/R64XTwu+Tb/uSw5QTIGOSz0gDKtdh6wf+/LJqLK4KX5iccn8B1Vmdvi4
	nwjYE1FJhVteRwqp1dC6Wlqci1ud/n+vpn7k3d41wTvF4IHjfZ+WTnxhPfuXdgh+qXW+8bL92ehpU
	gw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4AM9LGVg2306549; Fri, 22 Nov 2024 18:21:16 +0900
X-Iguazu-Qid: 2rWghK4ksq3SK6PNbT
X-Iguazu-QSIG: v=2; s=0; t=1732267275; q=2rWghK4ksq3SK6PNbT; m=WctMFjTEh8KVsduLGA9wctYw8C51f0ptj9KFfe+DtCA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 4AM9LDQD098558
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 18:21:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlGrAYp88cuNvAqbiJuWOUVonBUzVJXQZTHanqofgmaDIBnNjVaw9/DKqq1xwDU6+QtG+WmqSAZtKcyU38Bkvt8Z83lH1NGDOOV/dCHvCS1dQfSYMgB6Q/kWMVJo6fmfbtImueTIP1SoFbKGEb7cV4x9qHDtK5KG3vb/bwvA8IK1S/3tdOxpx2Q/xRSCdhDwumoVzIFdzKvxn9wOzZRWKZZnU6kLfH88TNz+Teezx4IggzB83HAY+kTHNosEj219sveGH/1momwtjZgH0sizDeo0b68M6vG96XgexkXcLjNQLvhH3nLw9iE+OjBBhVuhThXJ4Q/s+DUA9uXRP6Fhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNHYOaJbvqVXpbfk3RH4jSvO88ZQmZIKl11A4UGPI4g=;
 b=HuXx8M7hjPvQjHAjlpJSbR2flnSTHbfeq5D7jmBTttLJ8Iw7k87gEZwPy5o8Fvo4pOy2fup+ebfXOCTKleGTauRMSirU0wdpHe/actFm6Kyx7zZ400TM/msqPd3+a31xim9BeoRfUdUs0exmiF9LdzKDoZOUaARVAyavqe8y5C2aIqXPaoHAlecpri40oVSOwVNDP2mbIrL0Rx4fL4aI19gZboG33MDn61nkpE1oEzJrKsLlJcrLAABgfE0FSLIXU/5OTBaEvh8d9hiHFBsmyn4mcFsYEtzzSLuzl9jKYcSZKfzgQJHxONHJSniOd3nxDgko01ewKcWvahaQGuGS8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>,
        <pavel@denx.de>, <uli@fpond.eu>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.118-cip32
Thread-Topic: [ANNOUNCE] Release v6.1.118-cip32
Thread-Index: Ads8v5RnKZmqo46lSQa/4NaAWaevDg==
Date: Fri, 22 Nov 2024 09:21:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB63916137E4BE100E2FEEE5D492232@OS3PR01MB6391.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|TYRPR01MB13849:EE_
x-ms-office365-filtering-correlation-id: 14e31ce6-858f-4b12-2506-08dd0ad70194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dXFlSU54cEk4dE1LTC9LNnJML0pMWG9GNnR6RDA2RXdlaVVkK2Z5ak9Q?=
 =?iso-2022-jp?B?S015UEhOQjB0cGE3RTdNQVkzZmc5bXJ6REtmRXhRRks4c3VKWWNjczhM?=
 =?iso-2022-jp?B?MU9WL0lCUm5nUWVHMVRzWnlnZjlxcUtaZXFJRFZFNVVEWUF0TEcwWUpP?=
 =?iso-2022-jp?B?eVF2aXB4TzlDSFRnVDFHSHRRNGhpaWRFZDJKNFpjOER2ZWJHSVg4RGtU?=
 =?iso-2022-jp?B?TmR6WTRYNXVReTA2c1NPalllUlp0NDZ5NXJmaUs4ZE56UUJla21zQU5a?=
 =?iso-2022-jp?B?R2o0V3RVM2MyV0ZDVWxSeHVDNHpNZ2xUeHFBWnlBanREcVpNOG0zL0pT?=
 =?iso-2022-jp?B?TnRMd08yUjRWQ21STFQ2RG9hWG5hYWMvRnZ2ZDNtSFl5ZzVSR1hCVGZY?=
 =?iso-2022-jp?B?V01RalNNbGo4cXkrNWNFbGp1UlN2MDI2TjRnWGFIVk1FZC96U1Exb0Js?=
 =?iso-2022-jp?B?MmtaMi9pZlhjV1piYW8wNnJydW5RL0FoczNhUzlCWHVMdEZYY0xucDd4?=
 =?iso-2022-jp?B?ekpVU0ZwVW1vbDl3SDlLdytNMlpvZ2dnYWF4SGhlYmdmeS9LQ0xDcmxk?=
 =?iso-2022-jp?B?Ny96TzRuN0NtdGpIQUptZkRNOFR0cjBXNmM3WERkRVRhcnMrUll5Nnhr?=
 =?iso-2022-jp?B?QlBSSEJPQ243bTE5M0ZkRTdDLzdzN3J4RDRQQ2RiOTRYRUhYSmtKTTZB?=
 =?iso-2022-jp?B?eXZnZ2NmTVVYQTRZUU5meERmY2M4Y2Q1R1E2R2pWVTFmU3JwdStkZ2Rp?=
 =?iso-2022-jp?B?a1lldklhOEQ0SkJlQVNZQXZ5Q0ZGR0RPdlZoc2sxWExiNFlCb1ZoWWdI?=
 =?iso-2022-jp?B?WUNsUjZ6Uk9XRmQyTWVMWmx3QWhaUXhRK245TXcrb1BsZTNjLy9XNERt?=
 =?iso-2022-jp?B?Qm9UMVNvdG1TRUsyNE94T29wUWRlQkJhdEZqUVhtWms5ajkxSkgvZC9N?=
 =?iso-2022-jp?B?cDBCTys1RUw3Z3B5STZabU5FTWtpdHQ4dlRQUEdEcFBGQ2hIajVRVC8z?=
 =?iso-2022-jp?B?Wm1IMkVFZG83cHFCWDdrYWwyckVqdnU2RGdxcWUvOThUVGNPSDBnUG5k?=
 =?iso-2022-jp?B?RDR0ZW1xOUVRVGRlSC9RR2NZYlFrRDlhQk5hR3JuYmZsd0pSZS9TNHBh?=
 =?iso-2022-jp?B?VG9mcUx1dUJFRHhNSW9aUnNzMC9QcE1FbmxMK0VMcWFXTko0ajZySStB?=
 =?iso-2022-jp?B?bFJVL3U3UHAxYTlLaVhRM2tYV1ZBMXZSem5KWEtaaU9GZHhrS1VobjRT?=
 =?iso-2022-jp?B?MWlOZE4vYncxWTVyZ2xDeHFHVzF2bGpSalZFVFlxNTNVRElQSkN0eERa?=
 =?iso-2022-jp?B?amx2eXFxYnRhdXVZUGpDY1htMWR0MU1CVEpuNGZ4Zk5NOWFXMURYV3hq?=
 =?iso-2022-jp?B?L2RQMG9GNjJHU09UNUE3ZzZ4SmRzSVJKbC9SL3g2QVNPYUluVmNFWk4r?=
 =?iso-2022-jp?B?MDV3WVlQMXNXaVQxczBEbUhXK1k4eVdmbTNrQTUrNUUzbXBDNlJneUZU?=
 =?iso-2022-jp?B?VThRYmIwV29SVkFkWnNyUlpaZlJlR1VQNnhkSzNpWkhGTUFrWE5nMDdm?=
 =?iso-2022-jp?B?SXhGS1hubVRQVzBYR0VvVXZmYkVEbE1SaThQY3c4cWVVU0xhNVZ0NzEx?=
 =?iso-2022-jp?B?dTFwSTN6anhMRHAyMGJneDFLVFNwWmlJUkpaRVRUWU1zZlliRG9wT3NP?=
 =?iso-2022-jp?B?bjloMjlRM1QrTnVhaU1QNmtNR2FMSzh6RU1BQnBtOFIxUnc5SDZvczFC?=
 =?iso-2022-jp?B?cUczd1lmZUFIcFBaSjNEcmVSYjUvNlJDWFEvcUIreFcrK04rUDloMGsy?=
 =?iso-2022-jp?B?VGJsRnBtTlJqUzZySWxGQWdSSWd5YkVVUkM2Y3kra2RLV3E0NU92NVhK?=
 =?iso-2022-jp?B?OCtvbis2NkF1Y3VyRTRNNVY1M1BjV1NJSVVmNi9NWDQ2Lzc0K1JHU1Nv?=
 =?iso-2022-jp?B?Q1lYcWh6aEhTMVdvQ2oyLzFTNHZlKzIvQTVEdHBPcTFrQlltajM4ampY?=
 =?iso-2022-jp?B?cFBZd3dvbTNjK2dQbUxyU0pOWGt0TnpaS3FzWnQvRTNKbzBiNXg3WFBQ?=
 =?iso-2022-jp?B?Y1VGYUV5OXhkWW82blAraWpZK1Y5cWNITVZ5VTVxMC9Nc2F5OTl6TUgy?=
 =?iso-2022-jp?B?SFo=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?emRlVG1ZQ1M3RVh2Y2RWaWw1MkNtR0NBVXNyVmtwU1RwWk5vMStjTjhT?=
 =?iso-2022-jp?B?YkhTQjZLc0psNmhyVkxnQW9CZXdlcGdvMm5IUmxqOXkzNGtMNXE5VTNl?=
 =?iso-2022-jp?B?M0ZDZ2hXYi9NQkpBK2FZZEJEQ25PZFp3UzFPSS9lekl1eldFemJzb1pr?=
 =?iso-2022-jp?B?U3FhRThlMk9yYk00aEFmclZKaTVWRGxZak81TUhLY1BpNVlsdkFuSjJY?=
 =?iso-2022-jp?B?R1YvcFowaEpzUlRqY2ZtOHR0cWZSOEM0cnV1eGRYTU41QXAzcCtuZDRG?=
 =?iso-2022-jp?B?VVhZZTJONlJZQVR4VU1hNnpzME4xUWQrcVIyZk9makhHZ2w2UnZraW9a?=
 =?iso-2022-jp?B?dWFUTXpoSzlwTjNFTG9OQW9kRHhnaW5tSzR3TzFhSmU3bWJRYlo2clhU?=
 =?iso-2022-jp?B?UWpSQ0JGK0l4Y252N0pBZXh3Q1ZZWmdheDluemhtVG9RRitaTExOS0RT?=
 =?iso-2022-jp?B?VjZmdjhndG9yZElNckhTUFlLWWhaWXBDa21SVlZXa1drZ0JkWWg2UWp6?=
 =?iso-2022-jp?B?c1IwVVdiQU1OQU14YVlQNEhGanFSM09jWmRzQ1g4Q1ViTkFjaDh6RU1R?=
 =?iso-2022-jp?B?NW5WMDVEaFMrMyt2d1hjMjVtRmV1Q1NuQ05jZFVycUFMcys2cDZ4Y1Nx?=
 =?iso-2022-jp?B?SFRmZlFnQTBZZVl5VW9WNEFEeWJTd2FIZ3pIVC8zSDFTaFp6QU5mQWF0?=
 =?iso-2022-jp?B?am5wa2pGa3Q4L2ROU3pSYis2NXBRM2dkUFpZU24zUlRmYlFhQTI3RWRv?=
 =?iso-2022-jp?B?a1hpVkc1QjVXM1k1ZmJuRGsyY05CVlpWdE1JeHdSNDhHQjBiUDFoNTJX?=
 =?iso-2022-jp?B?MnZXZDFDM3JZdytHMDVmZFhHODRCdGpnUUl1SVVlYmdUUnRYREpxSUhq?=
 =?iso-2022-jp?B?cXlsNGVnM1JXbU5OeGZzei9EZ200RFVxMkFzN3VtNnBma1B5enV2ZEJl?=
 =?iso-2022-jp?B?NVJscGlhK1lqa05CbTlzOHhPR25SU3g4YzVQM25aTGduVytlS1BYM0I4?=
 =?iso-2022-jp?B?V1hJNEZzTnpJekRpeVJrc3Q4T093WTZXRmxacTNiRU9WWndNV3hqeHdq?=
 =?iso-2022-jp?B?b2JoQ01XOTByYlR3NE1GcjJTRzZrWmpQSStoYzdNcmsweTllZVhUUjFj?=
 =?iso-2022-jp?B?WE1Ld2tKcWZVenFsQy9SMUhvQmVaZTR5Y2ptUEpWb0NDamU4eWxNWk1u?=
 =?iso-2022-jp?B?WDREYXhtVTdvNkUvVi9qdUkzbG90RU1BMVdnOGVOazZZVndrYUxIb1lI?=
 =?iso-2022-jp?B?Y08vSjZmRWNhaFpxeXJ1Wm5IUERQODRpVVZkRHVNT1QyTkFndlZsOFlm?=
 =?iso-2022-jp?B?SnovNHFWTWYrTW9TYUhPdkxNWU1PRTZBQjluV1FuNHBINEYzTXVITS9L?=
 =?iso-2022-jp?B?UkhocTRrSFJvczJiUWE1OXhBS2JZYTd4bWk4SGtiMS8xVWp0Y1FsL3o3?=
 =?iso-2022-jp?B?Yk1TY1ZWNUFDSy9VYmttYUx4bmhaMFB6WlVRRm41Q0ZZdWdoaVBDTzZh?=
 =?iso-2022-jp?B?L0RtL0dJdkhNWnlaalZEQ1dLcGtvMWl4WDdvTzR0QjJTUUFQTGgyTWZr?=
 =?iso-2022-jp?B?TjExdjVHcVpSSTRwdW5HWWVtazVXYW5Ba2hHYzAxd2RENkptbTRIWWFK?=
 =?iso-2022-jp?B?eHBnZ25wdW4zeVZxU1g5b1R2L1Y1WjhPR2cwdThDNmticjNoS0RtdjNC?=
 =?iso-2022-jp?B?ek5QZndCWTdaQ2hNcUFSTmJ0UmQzRGlEUzVQVnFQK3hGeHVYSFUyYUNL?=
 =?iso-2022-jp?B?cThJank0MEVzTUg2KzRWZ2hFU29zUjRnZVhsK2MzNFVidHF0SU9NTEVJ?=
 =?iso-2022-jp?B?RnpLdkxDdTVCYmVSUmhzbEo1RFU5NzcyVTM3cDdGWVpsQTIxanJESnhy?=
 =?iso-2022-jp?B?V0NFcG5yZkFLN2ZZR1ZjUkpZUXJQTUFqeUdMalZvQzNsU0huUTMrdFpV?=
 =?iso-2022-jp?B?dG9Rc0NyMzJkOENqd1BpeWljK21CcUZXRHExV3IrRXQ1ZHp3SDZBZDIv?=
 =?iso-2022-jp?B?UlhmOHhmN0R5Q0RGc00xajYwbnlyQmhHQ0ROVDg2TlBrNi9HbFFzS0lt?=
 =?iso-2022-jp?B?alpCRXM5RjgrZkVZSkx0OW1hL01YcC9WMnpQb3FndVBSUEVWWHJvT3Iz?=
 =?iso-2022-jp?B?Nng1VXFoVkVudkp2eGR2bC9mbkNjTUxSMy81c3lVcGhpbTlnZHQ5VWNr?=
 =?iso-2022-jp?B?QVBLMEYyU0Y2dUdCdjBQVmliN1VqT2o1QURXc0N6dFFJV3I0c0tUdkpK?=
 =?iso-2022-jp?B?UVB0eUNneDBIVlR2c2FqNzZqT0pGMjh0cVFBeEhiemZRYStpRytiSEth?=
 =?iso-2022-jp?B?UytsYjZ5NFN0eXZTaUIxTDJJY28rVlYzcWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e31ce6-858f-4b12-2506-08dd0ad70194
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 09:21:11.6894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxdoA/i1WR5/R6GM2B3cHesdEEX0i1cspZtUUDSnssYs++h9gUAzCt7Ub0k6bcyb1l8u5rqN3GyQN7MJJS6NKdPiqnNqD9b7RH4AXGqhRHZ90S9vZk0eJ19n/rKj92gL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13849
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Nov 2024 09:21:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17267

Hi,

CIP kernel team has released Linux kernel v6.1.118-cip32.
The linux-6.1.y-cip tree has been updated base version from v6.1.115 to v6.=
1.118.
There are no CIP-specific patches in this release.

  v6.1.118-cip32:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      97394468b7933b436afd031c807a4f3c2ef9b8fc
    fixed CVEs:
      CVE-2024-36914: drm/amd/display: Skip on writeback when it's not appl=
icable
      CVE-2024-38540: bnxt_re: avoid shift undefined behavior in bnxt_qplib=
_alloc_init_hwq
      CVE-2024-41080: io_uring: fix possible deadlock in io_register_iowq_m=
ax_workers()
      CVE-2024-43868: riscv/purgatory: align riscv_kernel_entry
      CVE-2024-43904: drm/amd/display: Add null checks for 'stream' and 'pl=
ane' before dereferencing
      CVE-2024-43911: wifi: mac80211: fix NULL dereference at band check in=
 starting tx ba session
      CVE-2024-49950: Bluetooth: L2CAP: Fix uaf in l2cap_connect
      CVE-2024-49960: ext4: fix timer use-after-free on failed mount
      CVE-2024-49986: platform/x86: x86-android-tablets: Fix use after free=
 on platform_device_register() errors
      CVE-2024-49991: drm/amdkfd: amdkfd_free_gtt_mem clear the correct poi=
nter
      CVE-2024-50012: cpufreq: Avoid a bad reference count on CPU node
      CVE-2024-50036: net: do not delay dst_entries_add() in dst_release()
      CVE-2024-50067: uprobe: avoid out-of-bounds memory access of fetching=
 args
      CVE-2024-50072: x86/bugs: Use code segment selector for VERW operand
      CVE-2024-50076: vt: prevent kernel-infoleak in con_font_get()
      CVE-2024-50100: USB: gadget: dummy-hcd: Fix "task hung" problem
      CVE-2024-50126: net: sched: use RCU read-side critical section in tap=
rio_dump()
      CVE-2024-50215: nvmet-auth: assign dh_key to NULL after kfree_sensiti=
ve
      CVE-2024-50218: ocfs2: pass u64 to ocfs2_truncate_inline maybe overfl=
ow
      CVE-2024-50219: [REJECTED]: mm/page_alloc: let GFP_ATOMIC order-0 all=
ocs access highatomic reserves
      CVE-2024-50228: mm: shmem: fix data-race in shmem_getattr()
      CVE-2024-50229: nilfs2: fix potential deadlock with newly created sym=
links
      CVE-2024-50230: nilfs2: fix kernel bug due to missing clearing of che=
cked flag
      CVE-2024-50232: iio: adc: ad7124: fix division by zero in ad7124_set_=
channel_odr()
      CVE-2024-50233: staging: iio: frequency: ad9832: fix division by zero=
 in ad9832_calc_freqreg()
      CVE-2024-50234: wifi: iwlegacy: Clear stale interrupts before resumin=
g device
      CVE-2024-50235: wifi: cfg80211: clear wdev->cqm_config pointer on fre=
e
      CVE-2024-50236: wifi: ath10k: Fix memory leak in management tx
      CVE-2024-50237: wifi: mac80211: do not pass a stopped vif to the driv=
er in .get_txpower
      CVE-2024-50243: fs/ntfs3: Fix general protection fault in run_is_mapp=
ed_full
      CVE-2024-50244: fs/ntfs3: Additional check in ni_clear()
      CVE-2024-50245: fs/ntfs3: Fix possible deadlock in mi_read
      CVE-2024-50247: fs/ntfs3: Check if more than chunk-size bytes are wri=
tten
      CVE-2024-50249: ACPI: CPPC: Make rmw_lock a raw_spin_lock
      CVE-2024-50250: fsdax: dax_unshare_iter needs to copy entire blocks
      CVE-2024-50251: netfilter: nft_payload: sanitize offset and length be=
fore calling skb_checksum()
      CVE-2024-50252: mlxsw: spectrum_ipip: Fix memory leak when changing r=
emote IPv6 address
      CVE-2024-50255: Bluetooth: hci: fix null-ptr-deref in hci_read_suppor=
ted_codecs
      CVE-2024-50256: netfilter: nf_reject_ipv6: fix potential crash in nf_=
send_reset6()
      CVE-2024-50257: netfilter: Fix use-after-free in get_info()
      CVE-2024-50259: netdevsim: Add trailing zero to terminate the string =
in nsim_nexthop_bucket_activity_write()
      CVE-2024-50261: macsec: Fix use-after-free while sending the offloadi=
ng packet
      CVE-2024-50262: bpf: Fix out-of-bounds write in trie_get_next_key()
      CVE-2024-50264: vsock/virtio: Initialization of the dangling pointer =
occurring in vsk->trans
      CVE-2024-50265: ocfs2: remove entry once instead of null-ptr-derefere=
nce in ocfs2_xa_remove()
      CVE-2024-50267: USB: serial: io_edgeport: fix use after free in debug=
 printk
      CVE-2024-50268: usb: typec: fix potential out of bounds in ucsi_ccg_u=
pdate_set_new_cam_cmd()
      CVE-2024-50269: usb: musb: sunxi: Fix accessing an released usb phy
      CVE-2024-50271: signal: restore the override_rlimit logic
      CVE-2024-50272: filemap: Fix bounds checking in filemap_read()
      CVE-2024-50273: btrfs: reinitialize delayed ref list after deleting i=
t from the list
      CVE-2024-50276: net: vertexcom: mse102x: Fix possible double free of =
TX skb
      CVE-2024-50278: dm cache: fix potential out-of-bounds access on the f=
irst resume
      CVE-2024-50279: dm cache: fix out-of-bounds access to the dirty bitse=
t when resizing
      CVE-2024-50280: dm cache: fix flushing uninitialized delayed_work on =
cache_ctr error
      CVE-2024-50282: drm/amdgpu: add missing size check in amdgpu_debugfs_=
gprwave_read()
      CVE-2024-50283: ksmbd: fix slab-use-after-free in smb3_preauth_hash_r=
sp
      CVE-2024-50284: ksmbd: Fix the missing xa_store error check
      CVE-2024-50286: ksmbd: fix slab-use-after-free in ksmbd_smb2_session_=
create
      CVE-2024-50287: media: v4l2-tpg: prevent the risk of a division by ze=
ro
      CVE-2024-50290: media: cx24116: prevent overflows on SNR calculus
      CVE-2024-50292: ASoC: stm32: spdifrx: fix dma channel release in stm3=
2_spdifrx_remove
      CVE-2024-50295: net: arc: fix the device for dma_map_single/dma_unmap=
_single
      CVE-2024-50296: net: hns3: fix kernel crash when uninstalling driver
      CVE-2024-50299: sctp: properly validate chunk size in sctp_sf_ootb()
      CVE-2024-50301: security/keys: fix slab-out-of-bounds in key_task_per=
mission
      CVE-2024-50302: HID: core: zero-initialize the report buffer
      CVE-2024-53042: ipv4: ip_tunnel: Fix suspicious RCU usage warning in =
ip_tunnel_init_flow()
      CVE-2024-53043: mctp i2c: handle NULL header address
      CVE-2024-53052: io_uring/rw: fix missing NOWAIT check for O_DIRECT st=
art write
      CVE-2024-53054: cgroup/bpf: use a dedicated workqueue for cgroup bpf =
destruction
      CVE-2024-53055: wifi: iwlwifi: mvm: fix 6 GHz scan construction
      CVE-2024-53057: net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROO=
T
      CVE-2024-53058: net: stmmac: TSO: Fix unbalanced DMA map/unmap for no=
n-paged SKB data
      CVE-2024-53059: wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_=
send_recovery_cmd()
      CVE-2024-53060: drm/amdgpu: prevent NULL pointer dereference if ATIF =
is not supported
      CVE-2024-53061: media: s5p-jpeg: prevent buffer overflows
      CVE-2024-53063: media: dvbdev: prevent the risk of out of memory acce=
ss
      CVE-2024-53066: nfs: Fix KMSAN warning in decode_getfattr_attrs()
      CVE-2024-53070: usb: dwc3: fix fault at system suspend if device was =
already runtime suspended
      CVE-2024-53072: platform/x86/amd/pmc: Detect when STB is not availabl=
e
      CVE-2024-53081: media: ar0521: don't overflow when checking PLL value=
s
      CVE-2024-53082: virtio_net: Add hash_key_length check
      CVE-2024-53093: nvme-multipath: defer partition scanning
      CVE-2024-53088: i40e: fix race condition by adding filter's intermedi=
ate sync state
    added commits:
      CIP: Bump version suffix to -cip32 after merge from stable

Best regards,
   Nobuhiro


