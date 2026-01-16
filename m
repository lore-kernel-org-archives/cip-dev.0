Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E6AD4898A
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 11:51:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4389.1768564283484901769
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 03:51:23 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 60GBpLBU4092954; Fri, 16 Jan 2026 20:51:21 +0900
X-Iguazu-Qid: 2yAbYAX4jPlQkqoX2H
X-Iguazu-QSIG: v=2; s=0; t=1768564281; q=2yAbYAX4jPlQkqoX2H; m=NP/RXYSJV1ZcdG/nwU2Aa4/I6oipDX+iMcNwaPDeeYg=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dsyqY3Nkyz1xnZ; Fri, 16 Jan 2026 20:51:21 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYNCtP2NL6bT1Yw7x2s+L82KtHt/VwZdOaNW2hGJpXbu9zG+sz/3LKAAL7h7tuTgoXHBVG0smTg60rpIWxsHdNKuKoFmBcKlp3Il0kwpUZNP/X5Wl/dfVpLVTZ9qJY7blhVnSvbLCm1O4Kr8LGNTwCD35B3FGC60HLZSO63Ol99fMIYQ3MQ7gkYuKDpC7tmae74LZYxBTIQcrcI/+yRWuvWK5bdVrxBri/1GHGNnSg8YcffMmEEEmMm9W6cjoSqlOeKA0Nx3t78dz9f30JySuFwEA1R5BRfdba1P6ky2tyeHpibXaJRJMsqHeJXB3FDfQz0eiCjCE5BGFqxB+Sfhig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fdvUZl2/BmPLVlHb2BPOUbB8FjpDV2it5u1x66OHEc=;
 b=pz7RY2w04enGCVoZ3HPnwmypT2K3V5JoK31D0ItXTcJ/xkSnb5cErCHnsi985pU4Kl1mLxXaghXzXUcKSzol1CEkTPEff5CkPsILxFPNjq4v/r2XZzVgxE3XlrqxIQIOX5Fdqb4zKsH3sk4pxtYp9/GBQP9OMq45ShDDCnsJ8ET7o7aX29H352DO8y2UDb6ltcIJCOz4CdBRzU1gF5dy+/uacbfAuWUcyUrO2CJtAUZwYyimSFJoMqI8Z6g+YDZgC1yNb8FTBVVSwajcf+qsIhRgOGoCVzIaAYZ+i4+USfi4cHHT3OuWqQlqFE74WjaaGQE4u8ZD3SFt73hxsBZ38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <michael.adler@siemens.com>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <akunuri.sahithi@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>, <cip-dev@lists.cip-project.org>,
        <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v4 4/4] doc/README.swupdate.md:
 Add section for software update with wfx
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v4 4/4] doc/README.swupdate.md:
 Add section for software update with wfx
Thread-Index: AQHchU7LbC5vaydgKE2NkVWRic98ibVRx8OAgALqAVs=
Date: Fri, 16 Jan 2026 11:51:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669E8BB9339D6D1F7810032C48DA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20260114122517.1716929-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260114122517.1716929-5-Adithya.Balakumar@toshiba-tsip.com>
 <DFOEW2YQP65R.323L1O3Q5XG02@siemens.com>
In-Reply-To: <DFOEW2YQP65R.323L1O3Q5XG02@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TY7PR01MB13826:EE_
x-ms-office365-filtering-correlation-id: f6859715-7b8d-4391-de25-08de54f58fd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?YVA0V1RENnJtQ0JkWmVjaWNyU3VrRXIwNmwrNitFNEl0NU9QWERpUHhQ?=
 =?iso-2022-jp?B?UEtOMWZ2U2c2QURaMDdJT2hYdGd0RjVyUHBaOGRleFlUc2cwOU1EYnQ2?=
 =?iso-2022-jp?B?OHhtb3hUOFdKcWhGTUc5aGEyNHpTVnRMSnk2dHBQV2RGNndZb1haam9G?=
 =?iso-2022-jp?B?NzZId1BvcU1qOVA0TndPOTZiQnF6QVJrSlZ3SFpzdDFtL0h4NytqQlNM?=
 =?iso-2022-jp?B?L3hpM1ZnTUNNRk5CSmx2dnZieU5UYnFkWTFGRU1RcmJtZk9lYmJmb2Mv?=
 =?iso-2022-jp?B?WTNSSllualpHcHJHc0JnYWRWZkMxWktIWHhjOTF4cEpKZFJPUWcwMS9y?=
 =?iso-2022-jp?B?QlRPS1owbDgwWHBpajRwVlVkbkdZMkRxZlU0WHFlb1lyZS9pcmYvRnkx?=
 =?iso-2022-jp?B?R05ITW5KZkZoMkRxRUZXRzRmcGYzY3lHcWo1QldZREE0KzMyWkVnWXpH?=
 =?iso-2022-jp?B?TjlHWm1ZL0VIb3NLVWkxOEVYc1FRTHlEenZYejY2ZTlKaXdQMXNmenNS?=
 =?iso-2022-jp?B?aFk0MHhrVWVUSWUrdzc0RFR1N2NCNFlUdEo3VEZ0N2dpV3d6UWhQLzNk?=
 =?iso-2022-jp?B?UWJSVS9yeDZkVjJKMWlLRzFQVUZoeUFzMXFobDlPVXduTjdCUEVrSEh2?=
 =?iso-2022-jp?B?UEs1V1J0dkIzUW9RVFR2UUoxWXBLVjZWQUFEMlllNGZuUmlZQmFzYThi?=
 =?iso-2022-jp?B?b0NRWEpmOWdJMzdVbVFReFJIb3E0RkdQZXNjZThWOHhFNFczZ21BTW9h?=
 =?iso-2022-jp?B?QXNtNk5kaEZzaDBjemlJWExNV3ZGekVQbFpVRUgzRFhjcm1hekcyT0Fj?=
 =?iso-2022-jp?B?Y0VvYWN5dmIzeCt1WW9XK1hhQjBqQXhxZWhuYk9ra3V6aFNlem1MTnNx?=
 =?iso-2022-jp?B?UE9CaVZKR3daekp4NHRNajVRdWwxK3hxMWN0YVBlZnhVK2V0WElYN0x4?=
 =?iso-2022-jp?B?T2VqNUxWOTB3Qm1SMDFxMUV5N3VQSGZiekZMUnFPVi92TmJJNFdBT2s3?=
 =?iso-2022-jp?B?QWFGTVVwajI0b05hbHJwUC9aMDFuM3pDb1JwOEIvQ2dGMTBjV1dublg1?=
 =?iso-2022-jp?B?bG5xY1dpT1UrOVZxUWdMSFdNakM1UnVoaXphdWdZRHowd0YwU3Y0S3Ji?=
 =?iso-2022-jp?B?Z3FrM3JWNHBWZnZDeUJBU1YrbG1xMWdUQWpDNGJpWlpWU1lMQzFSeVhu?=
 =?iso-2022-jp?B?aHZxTDNHWW5Rb3hiS0VpUWZKbFlJNStoeWdRU2w3U1hZTWY0b2lOOGpS?=
 =?iso-2022-jp?B?WGN3Uzd0ZUtqT05jOGIrY05WdUt0eDNaYzdYZzVPOE9Ba0N6MVNGeWsw?=
 =?iso-2022-jp?B?ZnkwdU5CaDZTZmt5bzBLbTF1cDl4Rk9BdDByODdEdEwxaG9uSW93R1NQ?=
 =?iso-2022-jp?B?Mk4ycVhYT0hrNHh2V2J6SnBIdnh2cWRmSVNKb1k2eFpkOTdwYmJ1c3dm?=
 =?iso-2022-jp?B?dmpKM0lrcDlseFpvRjdGTVRtY05vZUU4dzlWU2hZU0EvMTVMUngwRTlT?=
 =?iso-2022-jp?B?MGtXaWZDZlVFdkJmOENpaHJqem84bW5xR2VvS1NuTVNtc0xkL0dlVnhT?=
 =?iso-2022-jp?B?cHVNSkRZaVRQRzJCWW5RbzZFYm9MTCtPRTZpeExTcWRxSFlhWm54bVRP?=
 =?iso-2022-jp?B?a2pETzB2MDNSQXE1aENSWGM0WTZxVDU4R0tVdm9Nb2RkeTNycXdoN1VN?=
 =?iso-2022-jp?B?TUpuZm9PUm9xNTdIYjg1V3VwQlFNV2NIZ0c5VC9hSkxGOEVZSlh6L1pL?=
 =?iso-2022-jp?B?ays2ZWVwL1M3YnBRcks4VHRIc2NCSDladEpRMjNCUGtCdzdicGRONnFr?=
 =?iso-2022-jp?B?cTJ5RjljTGlkWlcvQ04yODhhckZNMjdHM2pYZDcwYmZ1VW9EOEx2alRX?=
 =?iso-2022-jp?B?aGlWU2tPeUlJVE9MTlhnWHRKL1ZYdXRYZHlCUzRPblFnZ0pWU3FCMzdy?=
 =?iso-2022-jp?B?QjEranZ6Y2RieTM4UlMvU096YnBYRGtJRHFrSTdrVkl1Rk5DZ1BkZlRs?=
 =?iso-2022-jp?B?emFsRk1tQ09XMnFJTDVEaTh0eVN4dEJnTHYvbzlCTUhRTjJaSDNQRE1W?=
 =?iso-2022-jp?B?RzhiRG1JZU53SkhRWUdSNkpTcENENWZxT2hHejVHbHZZOWMydFpsdlVw?=
 =?iso-2022-jp?B?L1VHV0F2L3AwbWkyOGMrTkFZSllrdWlFSUJ2WVNvaXArc3g2c0FMUzFp?=
 =?iso-2022-jp?B?K1Mwa2ZjV1pEb091MEh2bmJTOUxKcFdxQ0RzdDdoUldPaDhuVFBDeC9R?=
 =?iso-2022-jp?B?NVlsL0VxZ0ZJYWNSSmxidVdvakZFN0wvTmRJQ0VlRi9nYm1mdUg4Qkxj?=
 =?iso-2022-jp?B?Wk5SYkxVenhQNjdtdU5nNWp5OHprTmNOWEZDTjJheldHcmxuTmpKS3FF?=
 =?iso-2022-jp?B?NHJsMEljL3k5Zkc1OFlCWU1EVlo1R1lZRHBDbUUyYXNDcUlYajdCdVBB?=
 =?iso-2022-jp?B?b3B6OTZBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?amI4TmJZbGcxL3p6Rm9DUlAyUXdGcy84NXdjOHhtaC8yZk1SV2hreXFs?=
 =?iso-2022-jp?B?WFpaY3I5NlBIUENFcDJnVWMwNUlZL2Q4bkVyRW5maThVMWJudGRBTGRu?=
 =?iso-2022-jp?B?eWl6SEhBMmUybVJtRmFoZWIrKzJpTVFRNGNKNGlmaDJ4Vm02VXhveXRa?=
 =?iso-2022-jp?B?K0tjVEs3R3pUZzhWSENQbGpLMTd4UUQ1dUtFUW5hNjlhUzNMajhVYVRC?=
 =?iso-2022-jp?B?bmVGbDdFQXNWR0gvZi9DNTM4TVhvMWJVZUtwQ3NoMXpIVnZNZ3FKNUh6?=
 =?iso-2022-jp?B?aVZUZ1hLQUMvbG9rZDAwTW1YRzFuaFhMWVJuSWF4cHVDNWtMd2hSUS8y?=
 =?iso-2022-jp?B?T3VWM3QwLzNpRkhZcjdpV3o3TkcvZzBNbEVpLzRySEFQc0ZCajNPeC9R?=
 =?iso-2022-jp?B?NVB2cmk4NkhydFVydDYwVlNkdXRsWGxjbHdmSFA5ZjMvSnRDNEZ4R2tx?=
 =?iso-2022-jp?B?c2Q1ckZGRkZRcHBHZVRGbWJsTWVNcGIrYUtpSWcyNThtNzB1azBKaCtW?=
 =?iso-2022-jp?B?UFZYY2xTOVVVamsxQVFIdTQ5L2tEejhtT1EwK0pmalIyTk9uR3ZkVWVV?=
 =?iso-2022-jp?B?a1Y0NkI1NmJiZG4veHFWcklrK2txazVKR1lMc0NvZkpDY2pZN3Z5M1Nj?=
 =?iso-2022-jp?B?VmZFcXBsUkxnMHdNWk5wdTlhbEVzdVhvclBLc1N5SVZoQ041RWg5blV2?=
 =?iso-2022-jp?B?ZGNZSzhIMkZsdHY3Z3pZSWNWMjRYakNWditLQ2lGSS8vRE93b2xwYlh0?=
 =?iso-2022-jp?B?MXBuS1pWZ2NWSmNpU3M0blJYNW90aDUzQldkQm1UeExzSVhIbzVianJP?=
 =?iso-2022-jp?B?cmwzQWY5bGp2MWpDa2NIUVFrdHdBdmpXSVhvRGpLVDM5RDBqcDk3UWJ2?=
 =?iso-2022-jp?B?V3dSZ3BuRi94RysvV1JmRVJHWDJ1bXhtdHpGbkNLOTdneEJJdWhlazhM?=
 =?iso-2022-jp?B?Ky9vaGNRQXpFZk9sZTRzMkl5V2U1TmJQM0xkc2tyL3c4UDVuWXp5Rmlu?=
 =?iso-2022-jp?B?OVV4dVBqQjhXTmJPSkFReWpNWXl3Y3ZxelZ2VytScDBBLzJrWmNiamF1?=
 =?iso-2022-jp?B?RENEenorSEM0L3RYMU00WmJGK1dQS3ExSENrWUhudkhTUTNSMTlncm5R?=
 =?iso-2022-jp?B?VnlJemcvNjJWaXVDbHZTa0krRXpXc0wzZU5Hc2lUbVdGWDFrZHFPQUJU?=
 =?iso-2022-jp?B?ZnpJdmFmOXl2ZEpqUmJlUUdMN1BoR3lyV1M4L2YrMFFXNTZBNTFpZVJT?=
 =?iso-2022-jp?B?L0l6TkhITE1kL1dCUjFUdlliaEp2VXRPQTYvOE8ya3duUVkzRlk0dE9W?=
 =?iso-2022-jp?B?NjlDdnZSY2JvMWJpZ2hCc0ZDRU04THRKbkI0ODNPb2dOSFJmYzFCUnZ1?=
 =?iso-2022-jp?B?bGpOUU1wZmM5QmhpU2hReE5jaXNJRzVtdDhkMEh5T3BnOHBaQXE4M1VE?=
 =?iso-2022-jp?B?YzFya25XeG1IYkpCSTB1eVhhWTBkZHNFOVE1b0lla1dreW5Uc1FiZW40?=
 =?iso-2022-jp?B?RitWMEg1NVVXV0N1b25sTFB3RUc5WFdPUlYxRzcvb3BmSURjZ2dWWUo0?=
 =?iso-2022-jp?B?Zm1QWmExdU5WZTV1QzZYZ2E1SWVOWHhjSzlWU3JZa0VoU2UwQm1RNmRz?=
 =?iso-2022-jp?B?K2U2SnQxdHNUWmxubTdmdElFcy9PYTdxbVZxQW1mbGJEc1p1MmNBVk1K?=
 =?iso-2022-jp?B?Wm9uTWd3ckpQWnh4TStmb2ZTNmEvcDRyUGdJWjBQbzR2eXNiUnNGandh?=
 =?iso-2022-jp?B?d2lNVVJtN1pGQTZtanJOQ2ZKN1JRVHlUSzVmSGJuL0UxVjUzNXJQMEln?=
 =?iso-2022-jp?B?K3NRZ2MrY01hYmlVMWMxait5aW9iVDZuVzJsQkVjQVNxbjA5cEdBUkw5?=
 =?iso-2022-jp?B?MHFhb0VuWEgzeVRONEpKUDR6QUtlMTVTbUMramhzdUF0RVUxZU1wUE92?=
 =?iso-2022-jp?B?SnNmL0VFMjFhVTlvTEYvWkxHc012MEYyZTNYKzJrWm04YW42L3B5YzFU?=
 =?iso-2022-jp?B?azg0VFJJQ2hmMFlwSnBUMG5wSExIbmtZenRQc1N5MFFYV1JuanZJYWls?=
 =?iso-2022-jp?B?bU9lb0doZm1WamlrVXpZV05WS0tyT1FIenNIejRMNFBDa01jRDFyU2k1?=
 =?iso-2022-jp?B?V3JHYkp5czFSbFlZeHR4WnY3RlZST1c1NTBMaEpsUnBRYTkreFYzck5L?=
 =?iso-2022-jp?B?aVJCbldseUV6QkJZc1RSSDNubGR2Tk5kSWVnd2dYdmlneGtlWERnRnlH?=
 =?iso-2022-jp?B?WDZ4TUZ6UG5sUiswckVxeENHNTZjcmxXRVpvVmxBMURONWZFcXNvNzFX?=
 =?iso-2022-jp?B?bzllektCaFdUUHJBTDRZUXpRU0hSYk1KM1M2bjZKS1RycGFYMXRMcVBN?=
 =?iso-2022-jp?B?c0ZHbmJmZ3ZzMjhUcEh2Zm92WnFJNWtPTFhTYlNnb2RCVWVnUjJILzd1?=
 =?iso-2022-jp?B?aWlod0lyU0F0ckc3aDJIcHU3MjMwakF5R1loL3RRZndyeE5FemcvSDhV?=
 =?iso-2022-jp?B?WGhmWWZ6eGxqT2lWQzE2bVB2VEJMeHlLd05rYUgxcmsvUVVCTWxPWFNj?=
 =?iso-2022-jp?B?cVY0ZVRXST0=?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669E8BB9339D6D1F7810032C48DATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6859715-7b8d-4391-de25-08de54f58fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 11:51:18.8945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrN4Q8+N3v0GfEjoCwg9o1+THX7XCTLSSJN8W3SJWsZE2M+LMyabTSwHm7cmwyAmH+QJwntES+RsGEgK9ahfnj7ouAsvJSLWDEkzK8n0s+Ioo4SKxD2qBvpF5ObsYaWh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13826
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 11:51:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21636

--_000_TYCPR01MB9669E8BB9339D6D1F7810032C48DATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Thanks for the feedback. I think I have addressed them in v5.

Regards,
Adithya Balakumar

--_000_TYCPR01MB9669E8BB9339D6D1F7810032C48DATYCPR01MB9669jpnp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Michael,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks for the feedback. I think I have addressed them in v5.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Adithya Balakumar<span style=3D"font-size: 11pt;"><br>
</span></div>
</body>
</html>

--_000_TYCPR01MB9669E8BB9339D6D1F7810032C48DATYCPR01MB9669jpnp_--


