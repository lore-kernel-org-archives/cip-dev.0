Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71511C3DA49
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 20:01:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.45406.1721937675145271660
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jul 2024 13:01:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 46PK1BYt2177194; Fri, 26 Jul 2024 05:01:12 +0900
X-Iguazu-Qid: 2rWhoo1A0Niyyxlo6F
X-Iguazu-QSIG: v=2; s=0; t=1721937671; q=2rWhoo1A0Niyyxlo6F; m=BgwTpoSi1FHl/QyMLSQ3l8ka8q4LZRgdLqiecnLlwBg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 46PK19Jw2522277
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 05:01:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/+p30Fir8mCOwBCMQWtzg3UUd9hSFnpuEgST1dPME+6g97E7avsJqq5mbXM48yFBLnS8Wp0D6VHKFNDHoJA6SUrP4z0AJUrzy5TyNmfhjKMvUuccICxY2oWI7BqS8z42S5/gR50A1Fhup4kYgcPu/dXKpZiLYzIrEZLluI92XQGgt+jWnt2FLjKp1VJnqlNlUODiAlkD9Fd9EkO1AE6IxvC88LKLGqt8QDcWFFF/AdYWCfont2bxqOp3I81ybB3VRvl+xjfZ99Afbcrz6DhTt2V3WVT9WsglFe91br4g5QphraWSkHn9Dgzp4D7Nu7x8VxpKmoB16JtyXJ6xG2dXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFuFAyqCuHKyPeXjhv+wTliypD5d49YAnBnoHiiX9oA=;
 b=ShSqg5R9H770lAjU1NksWiP9HRjLAwFUNVDQPt3hQfRENAaNrMK70jadH5chk30LG7dWCyuaG5jEDMbHHBHTxMHqcX7heR3/vGOJ1EDc6JllAyvlKDmI1bEWEsfzqgBkami33/loLAOLMNwm15ypKeehVv/QJ4RVA57A78UTpKTAU2G+JQS1GX4h+3D8s4UepJygE1H+zr4bwMNAR+f5gt6qUECA7GnoBlVnt2JMBjtB+V5NLoyRcgbCAtjI8bVRVdyQCJJ98GwXkcziFQwCCaipNKnDTuxGaV5K8pwbMH/VHs2tnOMlfA3yS6H0hdH119ZOpSgM8tH+t+wvYPn6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Subject: RE: Sporadic failures of swupdate tests
Thread-Topic: Sporadic failures of swupdate tests
Thread-Index: AQHa1GEaJrvjQ9LEBEqUr/NOQi8XF7IHAL2AgABrsFCAAFOUAIAALcaA
Date: Thu, 25 Jul 2024 20:01:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61039127C5BDFEAD794823B0C2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <93e132c8-3229-434b-98ce-169138889a38@siemens.com>
 <OS3PR01MB6103DECD8546D119F436938FC2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103DC424B825831970AA3F9C2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB12402D59452F7EA25A8DE10D7B7AB2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYYPR01MB12402D59452F7EA25A8DE10D7B7AB2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB8586:EE_
x-ms-office365-filtering-correlation-id: 37e99cb1-248f-409b-23b7-08dcace4849e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?LzFSNlBYUzlwSlFXdlJXTEZaOHk0TlN3WUlUQWw5ZU5Yc0JEaSs4aUVa?=
 =?iso-2022-jp?B?cjZiQ2FjU29CeTlhcUxDaVFKemVYRXN5QlpsYnR6WDdRSnhHY04xTi9U?=
 =?iso-2022-jp?B?ZjZmMFlXVG5xSFZicHBVK0RqNG5IT0Z2eUdpdkhwNVZVWDgyMUJucWhS?=
 =?iso-2022-jp?B?cDdiZjdDNDRTMGlkZ2dBRll5ZGZ4cDE3TCtlc1VIanVHUjVoMFZLajVK?=
 =?iso-2022-jp?B?UkxZSFRnaGFZSUhJakRtTHNEZWtPdjFZZ1N6VllHSDZ0eFJWVVBGU1pS?=
 =?iso-2022-jp?B?aFloQnVET0xqY1NaWmtVZnNtS2tuT2w1bEVpVDRYMTdySVg4R2VSK3g5?=
 =?iso-2022-jp?B?NHl1V0YxSCtyQllPTTJMY2tUVGdpS1ozWmVaQjFuaE5FcHoxNCtaM2VI?=
 =?iso-2022-jp?B?b1MxQ3hnN01qU1BOUEh3RkdBVnhzM3c0UzMxeGppTDJsaWkrMnVSVXI2?=
 =?iso-2022-jp?B?RDNYQTI3YWs5WFl6b3kySGlQTlVZSE5LWnk1OUhYa3JFVVQweWx3YTJ2?=
 =?iso-2022-jp?B?aENILzIrSzN3dDkxTUFFRlBPRVpLMEdwWDRKVmY1eGlJdThHTjd2Wk9u?=
 =?iso-2022-jp?B?b0JBMGkyd2N3MlhPakwvUXpXSUttQVUvd1U5UHRiNXpKQWNXZDFiL0ta?=
 =?iso-2022-jp?B?WFdDY29ONUx3MC9VcnUyT01JV1ZRcDBQK2l0TEVyS3gzaEFITncyTHow?=
 =?iso-2022-jp?B?QmFMaDNRK3hPazhUcXA1aVFsZmJCcG1INWdYNlJqRXBPcVBOeGNxb2pN?=
 =?iso-2022-jp?B?aGk5ajUvZEYwZmk2TXhaSWZsNUJHbXg4Q1dmMjZiM1NCbjNLVkNwaDBR?=
 =?iso-2022-jp?B?dFg2eG1EMUYxT3Rlb1YvUzVDMmgyV1p1ci96ajUvbmg1aVYvUHJKYjFm?=
 =?iso-2022-jp?B?V3pJY056SEFZeU9hZ1lXRUxSQmxWd0RyaGRIWlk4b2JQd3VHUnVXRVdU?=
 =?iso-2022-jp?B?SUVnSVZhT2V2Y3B1TXk3UEVWMWp4S3ZNUGlCdXk2Q2FtL1kwc0NwN2Zs?=
 =?iso-2022-jp?B?K3JvRitnUEpqOVZ3TWJ5MXM3R3crSVFZcE9PbEQrVVNMU3U5amZVcHR0?=
 =?iso-2022-jp?B?WEYrWm03SnVLak83bnRDS3k4bkFGME1WYzA2YmJ5RmpBeEVUUVcrY1hJ?=
 =?iso-2022-jp?B?OEVNY1FKb3Y0aU9HZTNDNDhiQ09qMkQySkdTSmMwOUZtS3ZJWkFHNmxz?=
 =?iso-2022-jp?B?WXlLdnIwN0JsaGxuQUVUaXMyaEdpd2RKb2pGbWtyZ0ZnVk9LNkxKRXRQ?=
 =?iso-2022-jp?B?K08ybHBGK0NESXh0WTNudDdLYStKallUcUkzaEZqS3ErZjRxTmRzREhp?=
 =?iso-2022-jp?B?L0Z3NHlKRVI4aElTbjBOYVk4L0xKS2Y5RGM5MklrMndqeEltRmdqTXBo?=
 =?iso-2022-jp?B?eVRoREUraktLcGtmSUdZZWxESEMvdG4zZ2plSzU5aUtnVkFaR21iYjFL?=
 =?iso-2022-jp?B?QXJCbnkzREppUGV6YzJNdHg1UHh6Q1FGZ3d6QmxLb3lQWDBCZmNqZE9I?=
 =?iso-2022-jp?B?SVE5cG02MEtRMFlWOHpyTU9iZnMvTzdYeFBKcnNUbjB5VnUxL1pTUXZG?=
 =?iso-2022-jp?B?RU55UXgySG9BRU0vVEZFUFRmN3pMc1VHZmlsdE14N3U5Vkl4QVBPdGJ6?=
 =?iso-2022-jp?B?SWt3QmpTT3JLM3Z6TFVIZmVtdEtXd2daT0phSG5vN1prUkRoVmplSW80?=
 =?iso-2022-jp?B?ekd2ME5Wc0FsWUtGK1hsMCtkN2l6Z3FENWFQd3NCTzNSWmlSMkFqR1ht?=
 =?iso-2022-jp?B?MFBabC9OVG1ZUGxVR1RPSVJJSEVCemdab1ZKb2t2bDlOVFRpTEFMVUJN?=
 =?iso-2022-jp?B?Y0ZwNHBNVnQ4ZEFHMEwya25BNzBzTWJBRkFzdFZHRitxS0k5Q3lSUlJw?=
 =?iso-2022-jp?B?dTNwc1lEMzlodjVIYkNzb2FQaHllajJFeVo4eVFkMWJETHFTS0J0RExT?=
 =?iso-2022-jp?B?MEpaOGZrSTdrSU8yQW4rUFJZVlRRcWtONm1FS2VUaFpoN0VDbXRVVDBn?=
 =?iso-2022-jp?B?ND0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bTV4SGp6enFhWDNrVlZmdEFmQzZId3pzdkZBaHlLa0Rqbm04aldQL2tn?=
 =?iso-2022-jp?B?VlBaQjQ5TElkTFVHNDA5clZHck9OdXFReHRxalBUUGxTYmxpTkxKcmhR?=
 =?iso-2022-jp?B?U3hMdjVBYkN0YU5rYVBWY1loNnc4R00zWEtjWDlMeE0wczQyem14ZHNS?=
 =?iso-2022-jp?B?VTdMeHhnaWd6MXpxRVc5Ui91NnBYSHhwZ2lkVUlpZG9yTGVTWXllNGUr?=
 =?iso-2022-jp?B?WUVERGV4Y2ZFYzZZa0tyMmRJUDRQY0NiRDFxQUNnQm00UFVVR095WnMz?=
 =?iso-2022-jp?B?OHgyK3VFWHlNUmQ3eFdlMnZNbWlFalRSc0dyODJyZ3M3SWdNaVhqQ0Nr?=
 =?iso-2022-jp?B?NG9ENHdLU0JYSEpEc1FOMDBQbUxxOG1iWWpSVENZb1FwVWlMR3VhTWFB?=
 =?iso-2022-jp?B?cTJzOThPcldoeXJPSzhmazRGNVYxVWhJUFlkREhhYWpNM0lTaXdvbmpy?=
 =?iso-2022-jp?B?MFV3T2wrZDU3UUN4aTh3QVlhcUJJanRQNTNUM2thSmt1WUVsMnVXVVhL?=
 =?iso-2022-jp?B?SDI1WGVXaGhtaDVuY0lTR1ZKNUZSeUIveWpheDZhbUJxb3A4RnV3WGpM?=
 =?iso-2022-jp?B?cHdtQndleEJ4NXRVNXgxNU96MGRoV05IR1lRc1pFMmkzWkgvN2pEeTdo?=
 =?iso-2022-jp?B?ODQyYjF3N1hvb2FtNUVRcjBwTW03cWpYOG1tRGxhV3lyaTRVMnFhVDZh?=
 =?iso-2022-jp?B?YkdSRGQzajljOTl4amZIM2Z4dlk5WmR5Q2xIeXdCdmNFZ24xbSt5N3Fm?=
 =?iso-2022-jp?B?bHZWQkU3Y3ZpYUxjYi9ES3djMkZmalFEa1p2ZlZ5b3JKem1uNkR2Z3Vv?=
 =?iso-2022-jp?B?WGkxckQrU3FJeFR6YlNJamdjeE8reEhheXlORTVrRWlvRWJhZUpEQUZm?=
 =?iso-2022-jp?B?RFpOR3Z6TVVSQkVqbklVZzFqSGVwRUhZVjJydE1RVWliQnRKZ01rNFdX?=
 =?iso-2022-jp?B?bW9ob3JwN3hEVW8zWnVGdHZmWlVMVzRoeFZuUEc1N0lHbDNjNFBnd2ZK?=
 =?iso-2022-jp?B?NHpWTldrWDdlK1hrWUE2ZmQ2RjNJbTF3L1dvL0tXaHhrZEwvYklPY1M4?=
 =?iso-2022-jp?B?bDJ6bmhXQk9hdFROamxRMytTRDQ2QUxvOXBrbnNWUDhUL0xXQjMyaTcx?=
 =?iso-2022-jp?B?NnNZVzZLTEVsQlFnMjdPekZyU25WQlFManBVN1JGR3pWS283aGd0SGlt?=
 =?iso-2022-jp?B?MmgwY21sWVVlNGpZR24xcmNCSXNSaGdpTnF1Ym5wU0xDVFR0Q3N1V0Vt?=
 =?iso-2022-jp?B?MWV6aW9TNUI5MWlVYU01cUdoQWlTamt2K2p0bjI1Q1pXWUVpeWZSNXNO?=
 =?iso-2022-jp?B?Y3BHeHE2dkJRWEJINVd2TkVyNnlmR0ZTTVM2UFRaQmNrL2NyeTVrYUFv?=
 =?iso-2022-jp?B?SHQ1MlFSOEhwLzRYdThkMDI1Vkw0djJoRHVYUDFyQnVNMytXbGsxRk45?=
 =?iso-2022-jp?B?RG9kUGZSaUUyeVJyYTR0WnlyNFQ0ek5rR1piVWdHR0Q2UVljSDlWVDZy?=
 =?iso-2022-jp?B?WUZmd3VjWithbFkveTgvRXpVdWozWnVoNWxHTVVRcTFBYkRFejdBOXpw?=
 =?iso-2022-jp?B?dzVDNks0VVB2R2R4ZEtGVlJoTTkwZ0YzbEFoUGp4cGZDM3htczBoWTZj?=
 =?iso-2022-jp?B?a1hERVFheXFiK1VHNXNTUVpCUWN3d0VEVDh0TWFXTllWRDZiSHFhdUZ1?=
 =?iso-2022-jp?B?bGd0WWxKZFJtcTBESlI4K3g3NnNXMDNpSS9yOWM3VHlRci8yNGt1ZHk4?=
 =?iso-2022-jp?B?bVFCdVhFVGJlOUlhT0RFaWF4NFRNTEp0Z2liVW12K21ocDBkd2g0SkVV?=
 =?iso-2022-jp?B?Z1h4bmlUQnJ5ZDdoZjBmWFl6ckVEY25RUnhqOFdCb0RBdjQ4UnpYRXBS?=
 =?iso-2022-jp?B?ZTRnRGZRYzI0azJxTWtWbnVETGN5L2NlNWhNdVBGN2hiQ1VjSWl5NS9m?=
 =?iso-2022-jp?B?bTVZMENaVFoxRVRwNmNaeTl1YU5rek9GR1B1RHpFQlMxZDJDd1hHSnNV?=
 =?iso-2022-jp?B?ZC9jYzYzTnVFVFl3V1YrZjFLSU1GN3IyM0RGMmRFRWx5Qk1mZ1pjRVdh?=
 =?iso-2022-jp?B?cjdFdm9VR2sxaTZPc1NZODNhV20zNmFRcnVyaTVBWnYzRmYwYU4yOVdG?=
 =?iso-2022-jp?B?amZucjZHcnVDZ1JRWGhRd29McTNSbW92VFVaTGFIZE1QeGRiNnRXa00v?=
 =?iso-2022-jp?B?MkhGdGRrV1JnQnBSODdPeERaRFJDOFRRNlFZZTJJZ3d5bFNZUldEajVy?=
 =?iso-2022-jp?B?clVFRXFkM09JQk43ZWFyVW85VzA3bWdlUnRsck55RCs4WDZLd3ErcGwx?=
 =?iso-2022-jp?B?aDdCVEh4aTVDZ21jV0w1RFlWUXUvWDlGbUIwemNkYXliOUVFRDBUMXI4?=
 =?iso-2022-jp?B?bE4xSGJmYS9jbURoREpScitOR2lxSE9oRFE2aU96dTRYMVpPNnVQRXpy?=
 =?iso-2022-jp?B?U0k1NzlnPT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61039127C5BDFEAD794823B0C2AB2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e99cb1-248f-409b-23b7-08dcace4849e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 20:01:05.6648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RIatZe8gMdxZlmGHfK480QLhoizMWGuhRc8SntXUrav900zum6XW73fLjV9s2Ehrxguc8iLySZ8Ua7cy8+rNULiF84yyNpnFN0wNYjzb40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8586
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jul 2024 20:01:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16627

--_000_OS3PR01MB61039127C5BDFEAD794823B0C2AB2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

The issue I have seen in my local environment is regarding TPM errors where=
 sometimes I was unable to boot due to =1B$B!F=1B(Bcan=1B$B!G=1B(Bt decrypt=
 /dev/sda6, rebooting due to panic=3Dboot argument=1B$B!G=1B(B -> https://g=
itlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7326477318#L124. My loc=
al environment is not LAVA environment.

The actual issue which I was mentioning regarding ,
>> For example, In this job  https://lava.ciplatform.org/scheduler/job/1164=
400#L1667, it can be seen the system is being reset multiple times in the m=
iddle of the boot process, finally leading to a boot time-out error.

This issue is occurring quite a few times recently and I have never seen sy=
stem getting reset multiple times in between boot process without any trigg=
er evidence even in the logs in my local environment while working with CIP=
 security target. So, I suspect it might be a bug in LAVA. Do you also thin=
k the same or is there is any known limitation causing this issue ?

Please provide your opinion.

Thanks and regards,
Sai Ashrith Sathujoda


From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: Thursday, July 25, 2024 10:32 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
Subject: Re: Sporadic failures of swupdate tests

Hi Sai,

In your email to Jan earlier you said that you've seen these issues in your=
 local environment. Is this local env also a LAVA environment? Or is this i=
ssue also reproducible outside of LAVA?

Thanks, Chris
________________________________
From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Thursday, July 25, 2024 1:14:43 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org> <ci=
p-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>>; jan.kis=
zka@siemens.com<mailto:jan.kiszka@siemens.com> <jan.kiszka@siemens.com<mail=
to:jan.kiszka@siemens.com>>
Subject: RE: Sporadic failures of swupdate tests

Hi Chris,

Currently Swupdate, Secure boot and IEC layer verification jobs are running=
 in CIP LAVA Lab from past 2 months. Recently there are some issues rarely =
seen while booting the image where the system is being reset multiple times=
 during boot process leading to a timeout error. It is not like that partic=
ular lava slave machine has an issue because the next job running on it can=
 see successful boot. This situation is seen irregularly.

For example, In this job  https://lava.ciplatform.org/scheduler/job/1164400=
#L1667, it can be seen the system is being reset multiple times in the midd=
le of the boot process, finally leading to a boot time-out error.

Do you have any idea about this ?

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

-----Original Message-----
From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Thursday, July 25, 2024 11:46 AM
To: Jan Kiszka <jan.kiszka@siemens.com<mailto:jan.kiszka@siemens.com>>
Cc: cip-dev <cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project=
.org>>
Subject: RE: Sporadic failures of swupdate tests

Hi Jan,

I sincerely apologize for the delayed response. I observed these rare TPM e=
rrors even in my local machine during development and testing with security=
 target even though we made sure to run one security target at a time on on=
e lava slave machine to avoid any TPM related conflicts.

Currently I do not understand why system restarted in the middle of boot he=
re -> https://lava.ciplatform.org/scheduler/job/1164400#L1667 and this rese=
t is happening irregularly at random times during  boot.

As of now I believe it has something to do with the state of the slave mach=
ine on which the test ran in that moment. I went through the list of all th=
e unexpected failure jobs till now. Some of them came under 'LAVA Bug error=
' and most percentage of the failures came under the category in which syst=
em reset is happening right in the middle of the boot process.

I will discuss this point with Chris, and I will let you know the issue as =
soon as possible. Once again sorry for the delayed response.

Thanks and regards,
Sai Ashrith Sathujoda

-----Original Message-----
From: Jan Kiszka <jan.kiszka@siemens.com<mailto:jan.kiszka@siemens.com>>
Sent: Friday, July 12, 2024 7:10 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>
Cc: cip-dev <cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project=
.org>>
Subject: Sporadic failures of swupdate tests

Hi Sai,

where are these tests actually failing? The also reporting that they are un=
able to clean up the jobs properly, but we rather seem to have TPM errors:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7326477317
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7326477318

Retrying them sometimes "resolves" the issue. Can you check if there is a w=
ay to improve reliability to avoid any false negatives? Or do we really hav=
e problems here?

Thanks,
Jan

--
Siemens AG, Technology
Linux Expert Center

--_000_OS3PR01MB61039127C5BDFEAD794823B0C2AB2OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Hi Chris,<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">The issue I have seen in m=
y local environment is regarding TPM errors where sometimes I was unable to=
 boot due to =1B$B!F=1B(Bcan=1B$B!G=1B(Bt decrypt /dev/sda6, rebooting
 due to panic=3Dboot argument=1B$B!G=1B(B -&gt; <a href=3D"https://gitlab.c=
om/cip-project/cip-core/isar-cip-core/-/jobs/7326477318#L124">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7326477318#L12=
4</a>. My local environment is not LAVA environment.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">The actual issue which I w=
as mentioning regarding ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">&gt;&gt;
</span><span style=3D"font-size:11.0pt">For example, In this job&nbsp; <a h=
ref=3D"https://lava.ciplatform.org/scheduler/job/1164400#L1667">
https://lava.ciplatform.org/scheduler/job/1164400#L1667</a>, it can be seen=
 the system is being reset multiple times in the middle of the boot process=
, finally leading to a boot time-out error.<br>
<br>
</span><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sans-s=
erif;mso-fareast-language:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">This issue is occurring qu=
ite a few times recently and I have never seen system getting reset multipl=
e times in between boot process without any trigger
 evidence even in the logs in my local environment while working with CIP s=
ecurity target. So, I suspect it might be a bug in LAVA. Do you also think =
the same or is there is any known limitation causing this issue ?<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Please provide your opinio=
n.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Thanks and regards,<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Sai Ashrith Sathujoda<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Chris Paterson &lt;Chris.Pater=
son2@renesas.com&gt;
<br>
<b>Sent:</b> Thursday, July 25, 2024 10:32 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt">=
=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:11.0pt;font-family:&quot;=
Calibri&quot;,sans-serif">) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org; jan.kiszka@siemens.com<br>
<b>Subject:</b> Re: Sporadic failures of swupdate tests<o:p></o:p></span></=
p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Hi Sai,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">In your email to Jan earlier you said that you've se=
en these issues in your local environment. Is this local env also a LAVA en=
vironment? Or is this issue also reproducible outside of LAVA?<o:p></o:p></=
p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks, Chris<o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;<br>
<b>Sent:</b> Thursday, July 25, 2024 1:14:43 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip=
-dev@lists.cip-project.org</a>&gt;;
<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a> &lt;<a=
 href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a>&gt;<br>
<b>Subject:</b> RE: Sporadic failures of swupdate tests</span> <o:p></o:p><=
/p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Chris,<br>
<br>
Currently Swupdate, Secure boot and IEC layer verification jobs are running=
 in CIP LAVA Lab from past 2 months. Recently there are some issues rarely =
seen while booting the image where the system is being reset multiple times=
 during boot process leading to
 a timeout error. It is not like that particular lava slave machine has an =
issue because the next job running on it can see successful boot. This situ=
ation is seen irregularly.<br>
<br>
For example, In this job&nbsp; <a href=3D"https://lava.ciplatform.org/sched=
uler/job/1164400#L1667">
https://lava.ciplatform.org/scheduler/job/1164400#L1667</a>, it can be seen=
 the system is being reset multiple times in the middle of the boot process=
, finally leading to a boot time-out error.<br>
<br>
Do you have any idea about this ?<br>
<br>
Thanks and regards,<br>
Sai Ashrith Sathujoda (T S I P)<br>
<br>
-----Original Message-----<br>
From: ashrith sai(<span lang=3D"JA">=1B$B#T#S#I#P=1B(B</span>) <br>
Sent: Thursday, July 25, 2024 11:46 AM<br>
To: Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@sie=
mens.com</a>&gt;<br>
Cc: cip-dev &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@li=
sts.cip-project.org</a>&gt;<br>
Subject: RE: Sporadic failures of swupdate tests<br>
<br>
Hi Jan,<br>
<br>
I sincerely apologize for the delayed response. I observed these rare TPM e=
rrors even in my local machine during development and testing with security=
 target even though we made sure to run one security target at a time on on=
e lava slave machine to avoid any
 TPM related conflicts.<br>
<br>
Currently I do not understand why system restarted in the middle of boot he=
re -&gt; <a href=3D"https://lava.ciplatform.org/scheduler/job/1164400#L1667=
">
https://lava.ciplatform.org/scheduler/job/1164400#L1667</a> and this reset =
is happening irregularly at random times during&nbsp; boot.<br>
<br>
As of now I believe it has something to do with the state of the slave mach=
ine on which the test ran in that moment. I went through the list of all th=
e unexpected failure jobs till now. Some of them came under 'LAVA Bug error=
' and most percentage of the failures
 came under the category in which system reset is happening right in the mi=
ddle of the boot process.<br>
<br>
I will discuss this point with Chris, and I will let you know the issue as =
soon as possible. Once again sorry for the delayed response.<br>
<br>
Thanks and regards,<br>
Sai Ashrith Sathujoda<br>
<br>
-----Original Message-----<br>
From: Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@s=
iemens.com</a>&gt;
<br>
Sent: Friday, July 12, 2024 7:10 PM<br>
To: ashrith sai(<span lang=3D"JA">=1B$B#T#S#I#P=1B(B</span>) &lt;<a href=3D=
"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&=
gt;<br>
Cc: cip-dev &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@li=
sts.cip-project.org</a>&gt;<br>
Subject: Sporadic failures of swupdate tests<br>
<br>
Hi Sai,<br>
<br>
where are these tests actually failing? The also reporting that they are un=
able to clean up the jobs properly, but we rather seem to have TPM errors:<=
br>
<br>
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/732=
6477317">https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/73264=
77317</a><br>
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/732=
6477318">https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/73264=
77318</a><br>
<br>
Retrying them sometimes &quot;resolves&quot; the issue. Can you check if th=
ere is a way to improve reliability to avoid any false negatives? Or do we =
really have problems here?<br>
<br>
Thanks,<br>
Jan<br>
<br>
--<br>
Siemens AG, Technology<br>
Linux Expert Center<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB61039127C5BDFEAD794823B0C2AB2OS3PR01MB6103jpnp_--


