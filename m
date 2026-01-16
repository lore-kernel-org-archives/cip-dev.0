Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6A0D4A60E
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 08:16:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1786.1768551403192636097
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 00:16:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=GL66I2yM;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1768551399;x=1769760999;bh=FaMu0aCIMOnXbvPp9Ty0yc+sHAuhm9GZIUv1Y
	bysRFo=;b=GL66I2yMQcibTDWxOFKzogQH0vzUNp8+2Yd2AjDUVz6/Vdnr9QXR6C5abO+z6KxtbM3
	ai0tMIr1pZp/MoEEGMD2xIZSW64d3VlRVSALk+xyvbWlbpKPMIPWHXWYahMqqV4qRajhuwo/nG1Aa
	G9EmXXJIWguOdmkgGT/cc3QTTv4rbzdKbm7qqngGlpwGkrzUzPLx82hzEeiXHBIrWwlhyvS2xdMlX
	/5rmaamJHMM27EXrKQThDE49E/PY1y+CmV6W+Oa2OFNMBNiMZQ3aYQOhJEthiN3Zr20MW/V7U9WKd
	taLManS69gv3iwuiFC2DbfO+CYboEawPbVkslp8bv8fA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 60G8GdVS1454086; Fri, 16 Jan 2026 17:16:39 +0900
X-Iguazu-Qid: 2rWhTylF6bpzbtfrrG
X-Iguazu-QSIG: v=2; s=0; t=1768551399; q=2rWhTylF6bpzbtfrrG; m=KJCKtrghWSeNtEb0sosBk7LB2aginK2iBOqZP07D4/k=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dst3p6g29z1xnf; Fri, 16 Jan 2026 17:16:38 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGYbpeQwWgRKOYMaAWeZJ7mFHddSDMYfUlwWzDqPFJlM71tCOKR70nPZ/je7SXttGsVEVG5KMcF7kBF4KV+PejRDaWwAy26sRF34Mk6Ob3iaPB1ii5MfsegvTPD5Wyxlb6zKiQGoNb47GJtjGL5aj4aAM+GtShPbQ05VqgmkMGg2TJ/9PHgM9tYYh6u2YDRfhio0Tp859B6UHdDleW0RyFp3g2eAre8iUqQtiwLKxOrdDvEIxHYEs0hrr+7tPmEkvtDOtbk+EmzT7dsM7j0NYZ9pmOBaM8KIFHH2q5bNF405PPtE79eZQ/cMCwHR95IV6VKJgQBgGuJnAeRSK3iqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIj+ary9X7KVb/hxRoGH/tyVrmad8fx8D8OFLaOosoE=;
 b=NcVt1JYbE/ngG1abw2eTlS0OSQfi+X8sZqT3XQ1a5cNAJtEaMT6xhF2wSUlXZga4Nqz0+S/8wxycfzzYxLZdR9yB5AyyZOmE9UtjT3bgCBLJmNhEtBj3eiRTmcxyexEHcCtZiiTsnYDV+sn/ugOCZQdc1flE/X6fcUbjD+r/l1nBnTFeUPrZ9JhALIqA3QQPBCMjRcEalpv1k0I32eaLY2to1d+YLIuchHewHV4paj3f/HZ3nxecGVdnlWbTxWsZaCLVlQDbMQYoLGEljqy/kpCadq8R4W/krk2mhEuFNd+yycILvSDzQvrviFRPxa2Sa6bqYm1JJ6rryRDf3rlgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.12.y-cip 0/4] Add RZ/V2N I2C support
Thread-Topic: [PATCH 6.12.y-cip 0/4] Add RZ/V2N I2C support
Thread-Index: AQHchVTfIsnhJJ5XKU2mucRuwBQFM7VTNXeAgAE/o7A=
Date: Fri, 16 Jan 2026 08:16:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CAEEAC8D66234B709B50CD8DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260114125359.8668-1-ovidiu.panait.rb@renesas.com>
 <aWjm1902KAC3sQ9S@duo.ucw.cz>
In-Reply-To: <aWjm1902KAC3sQ9S@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB12528:EE_
x-ms-office365-filtering-correlation-id: d47ebdb2-65ee-4621-e877-08de54d7913f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|14052099004|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UVVLUFJnM3lKbnltRFZJbUtZbmhJZGRTUSsva2NhTUpXZG1VNHcvOXdC?=
 =?iso-2022-jp?B?a2p2ZlRsZnhubFBGM1Vvczh4YWwwU3RBbXBnWThTYnVoOXY0T3BFWk9Y?=
 =?iso-2022-jp?B?UTAyYzRrbzI2Y05uWU5UM2hENGdFLzQ1MmFmUCtzR3RGejdWcXc2OHFa?=
 =?iso-2022-jp?B?ZnVvTVI5RjFQY2tjbFYvTHJGQ0VjUGpzN21VSHB6THQvRDJQU21JNnJU?=
 =?iso-2022-jp?B?NXJUamFRMFRZSTBhZmxSMUVFaTVrUVY5dWxMNkp3ejdaTEJVSzNldGU1?=
 =?iso-2022-jp?B?UjM1d1JYMkpGUmNXaWdmTUhIeStibjBvRXFBMUpwcXd1dUNtVDlQb1VI?=
 =?iso-2022-jp?B?eHBHdFY0VGtzSm9XMFJGZVk3cWd3YTF0MzNYSjFCcU9zYWdKUlZrVW95?=
 =?iso-2022-jp?B?RTh4M2NNNm9DYmRKemlFWHBSY1F6N3lDVllibEJMTDBKOWpBR3ZkeFdL?=
 =?iso-2022-jp?B?eVdtcEJra1JDYjRnZEZOSzk5NmJzNnJzSXpXMVdqUlNpdkszb0xNSzR0?=
 =?iso-2022-jp?B?RmlMYnV3NG9vT3JwUGpYelB5amprOWs4Rmx6THJyRkR2alpHWGtpZlVl?=
 =?iso-2022-jp?B?UVlRTUdLRUhMUVVkaUpyckdUUXFKSlQyOTVhSEVFdGNZM2lWbGJZREJk?=
 =?iso-2022-jp?B?TXd6Y1VCL0FOYnBxaDdKc09sT1U3alhOOVQrRUxqZm00bjRxdzMrNXV1?=
 =?iso-2022-jp?B?ZE03UWdINHMrUmhFWFpadmtjejdvR0lRSmZsMkl5NHNsNXo0bnhvbFYr?=
 =?iso-2022-jp?B?RzBzQzlDMVYyTXp3RXFrVDBVYkJWdFV3b0M0M1B0YUc1Y3A0YXNSZzgx?=
 =?iso-2022-jp?B?bVBGWEtscklSbGhjTUN2UExKVm41am9ZQXFPNi8vbG13N3lXUHE5TGtk?=
 =?iso-2022-jp?B?Q0lHMDdpZ0wzNldMcTFsMGV2dG1rVEQyNEliSzNtdWFXTk1ydFVoNm1S?=
 =?iso-2022-jp?B?WnQzQUI0c0NqcFpVOGhKOGhsTlhDNnM5bmZOWDY0NFZJWkt2N3pDamNC?=
 =?iso-2022-jp?B?eDU4TTNmeWxrU3ptMDhWQ25raXUyYitKYVRWWlFnMXptY3BUVTZuR1pw?=
 =?iso-2022-jp?B?QkhKS0xTby8wV1hCTnNmcTdVUDFhN3l1emZnblRFR0x3OFhxV1REdUlQ?=
 =?iso-2022-jp?B?Rkx1ck9LUi9uSFZaaVVtZS9xOEM4WW9hNVJHUEpSVnE3Q2hsQTl3NUcv?=
 =?iso-2022-jp?B?YTFlemNGTGJ3Uy9FcjBlb0pqZ1QwQ1VScnZmRW5aclhaN1Y5VGNYY1BJ?=
 =?iso-2022-jp?B?eGs1aWdpVzA4UHkzeENtZkcvWVdNbWFWWFRmRzh3TllnNU9yTkk2S3Vp?=
 =?iso-2022-jp?B?Q2l4QW12N2czd2t1eUJXZllNSFNkUWM3NWp3UjJRY0NqNnJQaUx1ZDly?=
 =?iso-2022-jp?B?TDlrdnR4TnJuQkF6OStXS244Rnh6aXJBd3ZQaVZERTNCd3AydVM0L0hU?=
 =?iso-2022-jp?B?dkc2Z3Nrd0ZOSWpkQm9GazZRM3d2UW56aUtxK3lUdVEza2oxbDhOb3Jy?=
 =?iso-2022-jp?B?NEEzcEMvdHAwVElDeE83TGpMK3pEbWxjZmZuSDRGMHRZZjdRQkZQcW9L?=
 =?iso-2022-jp?B?clhUbENCNThXRFIxNkxpVElORHRROHFZT3MyZ1J0SG1LYlk2bnZOVkVI?=
 =?iso-2022-jp?B?WDdXeEFVUGhOVVc1eTZsYUJPZGx4WCtPNkt4bEd6enYyTEdLdGcxR1dG?=
 =?iso-2022-jp?B?dDM4NjFMeUJQNEx1Wmlaa0V0L3lYNU9nc2hKeEJ1MWNSNzNTL2kzcTBH?=
 =?iso-2022-jp?B?ZnkzUG90WGRhUVkrK2FSa2Y2ZS8rTjNVU25WSzIybWpYZFU3OEMrUllk?=
 =?iso-2022-jp?B?cUQ4dHQ1NUxGb2VFYTFBQ21PR3o5dVplZksrSmdzQnU2cjBUb3dObk0w?=
 =?iso-2022-jp?B?dmtmeG9rcjBXQVFPN0RtM0FSdzV6dzdKaEFkWFJmMWRSU1NYNWYrL2ZP?=
 =?iso-2022-jp?B?UU8yNUVEK05DZHZxTjFaMFJTMnVDN2c3alpWdWhRNS9Kem44TmlhV1Mz?=
 =?iso-2022-jp?B?VlhUSDVLMk4zMXhxVEpiYTdpWWVRTEZjak54VitEWVBpRFJjZnJWd1cr?=
 =?iso-2022-jp?B?S3J0QXNGQlJYVnoydGxOVFFNbGU1MjVxSTl3Y0tLT3VQZTlRWDM0U2FO?=
 =?iso-2022-jp?B?VU5nbnVqK04rT1hkL1BXTVA3cVVrQVlkNDlNeHFnUjNLSlpvZU1ReHlS?=
 =?iso-2022-jp?B?OEZNL2xTQnFxMlAveFRnRmQvejdhRmFSNWpoczFiWDNRZEtTVWlMcExr?=
 =?iso-2022-jp?B?Y1RlMFRrK0lYRTFlY2xiYXFhRGNoTHV4VllBMWtJQkJqU2RBSktZRnRj?=
 =?iso-2022-jp?B?OGx1a2dvWHZjQVZzRDVvT0VhWmRNRGhRaHovbW1tVUhtNURwWnZvSW9w?=
 =?iso-2022-jp?B?YXZMOE09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(14052099004)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cENsY1hjQUZ0REF1RkxteDdDa0YzWWxyUE9jYi8xNXdndGg3RVFoeUZS?=
 =?iso-2022-jp?B?eU5FUno1R3BQM2NlZm94UjJwc0Q2THJoVVJzMEFoQkxlK21Bd2N5NitW?=
 =?iso-2022-jp?B?OU1Ld1RDalBiT2hISmliUmtaN1RucVdZM1Rib3Axb0hrRzA5VG55MGJp?=
 =?iso-2022-jp?B?cmRlRDJxMkVVTXF1amp6NjZUOVBRcUxsU2VJYklza2VUL0dVQVhvV3JB?=
 =?iso-2022-jp?B?K2ZobnZ1YzV3MjdXL09OV3pQODZyVFhDRS9pM1dIc2lXQXBPWHp1VXM3?=
 =?iso-2022-jp?B?ODlIc3BFSVN3R01Ma0NLOUNCZnpLb0hGaUZ3bUM3N012ZVg2RmZvOVhN?=
 =?iso-2022-jp?B?QzNxR2lUNUNFS1hycms1TytkV0k3dzJudGpPWjQvSDJsUDRTaWZCMDJD?=
 =?iso-2022-jp?B?Mi95eXFKc05oQkhicHdzWVJLUUVRajQxaEE2aXhTTWliSGZNaWZzQnk1?=
 =?iso-2022-jp?B?c0RBNSt1ZFlvd0VsWE9NbFllNVNNNXA1bHN5R1p0YTRsSWhmRktESzZ0?=
 =?iso-2022-jp?B?SHUreHJGdjc1MzdmNWJ5N1U4VEppbGttWnJTL2dERlBjNHp4Z2VYQ1pM?=
 =?iso-2022-jp?B?aVNaMStUM29VZWZKMFpQcU1rSjZ1SWxBVVNHY2pNd1BzSXVJczliU3FM?=
 =?iso-2022-jp?B?TCtnWEUxVVUrOTdZbldzUkpudng1TGx1UllJK3pmbGhBVW92TnByWXhC?=
 =?iso-2022-jp?B?alAwMmtuOUxnaHZkelFBanFnM244eE1mdnVQbmFpTEJSQ1JTUEFzb0ZD?=
 =?iso-2022-jp?B?cnlDMmpGMGtJY04vcnI2TEcySzh4ak5kYXhjSGRuMHFLS1FsdE1uNlVY?=
 =?iso-2022-jp?B?ZXVmdkR5b0VCODFLOXZqMGlGUmtwdFBJd2NPY3FQcXFQV1BSNlVGSGRr?=
 =?iso-2022-jp?B?Rk5LdEFxZEEySFFpYkcxUWFZUCtHZHFwOThtb2kyT0REYjNMUThMK29H?=
 =?iso-2022-jp?B?SGlkY3k3dGVvbFNHVE9hMGZTa1ljL3hPclpXR2pwRWp6SlVzUVFuTXk3?=
 =?iso-2022-jp?B?UEE1TE1YQU9vZWt0MjI1SjJFKzdhQTI4V3gwM3BnWFkvcmVkNDZiclJp?=
 =?iso-2022-jp?B?ZFVSOUtvYUl6TXN6QmdRSUhEQzFENVV3SFpmL3NQKzNyRVVOYUI1aGgv?=
 =?iso-2022-jp?B?V21Rek9OWDJTMUlBZk5EZGVFemN1Y21xSDJhY3BGd2R6SkxudkoyNktJ?=
 =?iso-2022-jp?B?dExGbFNkai96aTZUQmM4UDBHMU1CZURGeng3dzR0V0xJL2RyMWVHUjNL?=
 =?iso-2022-jp?B?a1prMElvc1V0TmtiTTFhZnpzd0NQNE41MVRMREhJRXhtN0xUR0VWeVBo?=
 =?iso-2022-jp?B?REZ3c1VYK0tMam15OWxLNlFRV2lWTkd4cXpocEdIZkZ1M2FSZCt5NENx?=
 =?iso-2022-jp?B?NWViTFIyQlNhRHZGTFU2YWRsYktyanM1dklKaVFFa3NwQXp1Q2FsaXRk?=
 =?iso-2022-jp?B?WXNwb054RXFvazYzTW1ocDVGMm9saDJhckNLR1FFQ3Q3U3QwY1VER0Y0?=
 =?iso-2022-jp?B?RXJKVVM3VUlaMzlEWU5uU0duUzBzQXdETUx6ZUtSRTRZMC9DYzV2Wit0?=
 =?iso-2022-jp?B?K09KSDhxb1B2YlVuNFBmeVV5SGtMZE1aNHUyd0VmaU9qYVBTLytyZVFE?=
 =?iso-2022-jp?B?UFpkL3lBZ2J1Smhiajd1MTRuaUFiVjVESTdVSnJUeTZ6bHovZE56OGhS?=
 =?iso-2022-jp?B?Mk1rcFh5Z1BrYldFRWJqTnRLUVlmYUNyakFHSk95YWlyZk9FSVhhaW1a?=
 =?iso-2022-jp?B?bkdpQjRzc25BRm5pNlRiWnFCaDcwaGx0c1lOL0NZS2lrMjNQMG43TFR6?=
 =?iso-2022-jp?B?SWJwOHkvVktCU1VNekpyM2FsM3hFa0FkUXhLaWRGR3dnV255SSt5d2dr?=
 =?iso-2022-jp?B?T2hoM1V2NFJPWTU1eUx1R3VwcUg0dTVPQmcwNnNxK0orQkVGVE50UkFm?=
 =?iso-2022-jp?B?WG9wZGs3MHRNZ0dzT2daR2dybWZIMGNBYUtUVVZHenFPMWpQbmlOM1NV?=
 =?iso-2022-jp?B?MHNUYVlvNnBSNGR5am9GU3dhckNuQ0pKa3NROUswWmF4bDJTdW5DSWtj?=
 =?iso-2022-jp?B?ZXBmK21Vby9BZE1jc1BUVDZTNjRFN3RVSllpd1VYWSsrdzI5OHZPVUEr?=
 =?iso-2022-jp?B?YnNZRjFqR1p1QzN0d255VTdhZmhLRTA5SVR6N20vZWw4TWNBVkxOc1FV?=
 =?iso-2022-jp?B?T09TczlOVXRyRHE4MVpVVDRyMVpYOE9rRVozQVNFNG55dWUvRU9UdUov?=
 =?iso-2022-jp?B?WXU3bW5tYS9ldEs2blg4WFlLMWZEaTlYZDlwUkpnZ05KdHgxWmQrVXZF?=
 =?iso-2022-jp?B?ckVTOW53L051VGU1WFhGdEcxMFhRY2R2NGN0Wm1UeGpsWGkzTVlMWVFl?=
 =?iso-2022-jp?B?SWxQVjV3YzlmRHdwYWlYZkw2T3UzOFR3Mi8zd0QrN3JEY0tudkFGSy82?=
 =?iso-2022-jp?B?Mm1TT2dHVlQ5T0YwZzd5TVpnck95L1Q5YkZHODFjcHM3QjU1QnFRT1pD?=
 =?iso-2022-jp?B?TUpaRkpFSVJWdkw4MjJNQlAybmxQcVhmL3A0MEtQa2p2VzhrNUFSMDBu?=
 =?iso-2022-jp?B?SlZTV2V2RT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47ebdb2-65ee-4621-e877-08de54d7913f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 08:16:36.4607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cq1kmGGlOe3gdAEfi7CWxhez2JiM5S0O7vedpt1agF3qeABPtYj2IoLpXZRetZXhKKgA1uO1kRic4uLpiKbFQBL/+WXS1keCp/PMq7XrbCemr286xK6oU2Sr46Fat4ZK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12528
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 08:16:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21627

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Thursday, January 15, 2026 10:09 PM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [PATCH 6.12.y-cip 0/4] Add RZ/V2N I2C support
>=20
> Hi!
>=20
> > This patch series adds I2C support for the Renesas RZ/V2N SoC.
> >
> > Patches were cherry-picked from mainline kernel.
>=20
> Thank you, applied.

It seems you haven't pushed yet.
Could you please push?

And, I reviewed this series, looks good to me.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


