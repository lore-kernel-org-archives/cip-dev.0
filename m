Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31372C282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 08:35:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.10032.1741854921777250235
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 01:35:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=frxKRWhI;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key3.smx;t=1741854919;x=1743064519;bh=xoihW7M3q9GVimgP7Ue4XROttSk7Xe388hcncp6
	aeqs=;b=frxKRWhILxRDxBLOs8KAwZpwQ+22OnMSYjaEmzQC+RU9n6JgilhT6Fds/AfMbsVcZMsVr
	ObLeCOixcHe8dIX+GCoBEV8heLsdA9iwwOkHTfjNB8QDJS058i6ZdO7gYrMe2KKMH9nMgFmzsLJt1
	nowLXBHY02jDuHaAzLDL5iJ6flNnqsDJPFUA00PcizxaYrBN0PJxXYzlY67YbwZadYxecNb2IBYhq
	kze7Qzq4rKoCvlnDy2lmEvZ2kSdQ2exatM8S0GrxE3A91+w2UfpvRgiCPFRvemmbYjPbwv1utmXNl
	H5tgpTelo13tfr8Rka0eMhHJiF17sqlo/H30Wu7SqA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 52D8ZJTv3531317; Thu, 13 Mar 2025 17:35:19 +0900
X-Iguazu-Qid: 2rWhBFYKJVW1Yj8rJ9
X-Iguazu-QSIG: v=2; s=0; t=1741854918; q=2rWhBFYKJVW1Yj8rJ9; m=e3eEeqO6mO0L6eXP9Q/EPQzElrtyknazZyZeSMIG+JQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 52D8ZHHp896623
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 17:35:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXV3Q0ifEHvqmKqUcitPNarCILYQhcxW5QamhIQWFEIp1ovdG3f9qXv0d4gW1D6LRo+zu5f3wZYP4lnrZSRiTvLP4qml6ahXP/3tmKEOToWciZuD3at53CzMNleeQT4wpwzN7ykJdmDM15xccLM9DepoQpLRiphB89UfO4jhiqrb883LN9jzFw/o6l0Ut8zQPQluDeFQocqgtXSAG50GHZ7t4HA9Xo9AgKPKcIhtVSVeEoW0b8MOKMht2VyoJLuFC1iPgomlbZSI11ozZAZvl6shFn9UPq/RatRX1qqebisBfIGbkDVUD1MIHZpbsQSfEMz1ek+uhx0uA/jt2MN+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoihW7M3q9GVimgP7Ue4XROttSk7Xe388hcncp6aeqs=;
 b=eMcvVrPvwi8yJV+DnVdXayJ2k5NsoYnVbPaVJ2Ypp0RoYYZflOcYl5jg3CAPx34zUJwVwK5pcByd2Ge4PL7kQCZ+8hquUBoR+hO1tlp1fsR0KkvQYlfqhdMxX0wFbMRvVkW2mPrGPtOt6VPZaS3Hb3uk8Dx7vVpTjHJToGtRmAzBP9kYgx7vl7G7hi1t/8UmD/E8IrcDYqDmSVJPg2PxkvKhLEwC4OruMVE6WBz9Wkjl+yzLP9k90iN7u7R4uxezM/c/BTc5eveyXJk3+AuDv+mtlHqgRgO4qUL4Aus4rmKM1moifLxJPLeDwRU/8oGSEgVA7NjadWH/SL0Uh5872g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHbk++wz4MfH87HWEmXqlP+/DVPwrNwvLKw
Date: Thu, 13 Mar 2025 08:35:13 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185E95C24F69566BC76B4092D32@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <af8dfdbc-27bc-4337-b899-03236bd23638@siemens.com>
In-Reply-To: <af8dfdbc-27bc-4337-b899-03236bd23638@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYAPR01MB6540:EE_
x-ms-office365-filtering-correlation-id: b027ebf4-d990-4289-211e-08dd6209f99b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RG1VL1NQY2tnRXV2Q1JCNzJja05LeWNtL0tQQTZVaXBiR25pYkFSdFhSL0d0?=
 =?utf-8?B?REQxRXUwODFvdTF3OVBmdDJVL25LWmJlOVc2T3RkKzUvc2g3U3lLb3hPOStZ?=
 =?utf-8?B?YXNURndtUzNFUGt5WUZUYXNmR2pkdjA1N3RYNE0yNkk2L0NTNUFQakpLRnd4?=
 =?utf-8?B?UlBHaTFCK1BCZ21NMUJxRFBVdlNPOEMwelUvelo0eEtNdElzNnBNRmZPM0ox?=
 =?utf-8?B?QmowdHU0elRqZzNTMHRodzR1eFptYUpmSi9vd3JjWHNkRW1sMXpwcERsMzEr?=
 =?utf-8?B?L0N4eDlzY21CTGp3YStDdWJ4VC8xMngvQW1TMWliRXoyY2ptaWNRVGhPNjVE?=
 =?utf-8?B?akt5Y0pETnZFTkdoWTBnT2lRWlI2OThDMGZESEpqbHU5OHV2bXk1cUlTcFha?=
 =?utf-8?B?cFMyamVQK2JyckxTUElkdkxVeHZLbjkzQzdXMTF0bDd3VmpUSzRXTTNhTXlT?=
 =?utf-8?B?N24yRVZrOExPZThVVzZrSlg4WWJzaGtXZktkMGNFVmlmVERzUVVWL0pRN0JD?=
 =?utf-8?B?UERsQ2JrTGU0N0FGUG11UWpHdHdySG9jdndldWh3VFFvNjBhRzh5OEQzc3RX?=
 =?utf-8?B?T2hEcWVPVHNOUHA2MUdPaHdnTFZSZEJkUklRUGVpeUpWWkRBS0VKbjUvS3JS?=
 =?utf-8?B?ejBzVmcwMGpESWxTQ0lQV2VNUWhaRThERDlNaXYvWGJnazFsQnJFNzAvcTZu?=
 =?utf-8?B?ZG1IeFFQc2N3VHRCaUhJZFFoY0pTazBsUEJSbVlCMFh4QWU2YWMrUnNwMWRY?=
 =?utf-8?B?eTFDT2trR0xYZ3pjQXdySTdUVVJnclBkMzYvVzNMTnBHSzR1bmpnSVE3UHJH?=
 =?utf-8?B?eGx1T3lqalRwQm15QXpCVTJkMHVHMTBWb3ZjelhXek5mL00wWTJRT3Exa0FX?=
 =?utf-8?B?VFR4QjUvQWRBVEs4NnNXOVllOUxBR2FWaFBoUVlkUmVBSnJ5UDBUWHVMaFpv?=
 =?utf-8?B?SjcvVHF4MkhQd2dTRWlURWRLZ0JqZUtlS2lKS2pRaHowc2hTa3g0WmdlZUFS?=
 =?utf-8?B?bTZIem1CYVJqVmtTSndRWWhiTklJTUZzNTgvSXBzSncwK0s3UCtxYWNtSkNM?=
 =?utf-8?B?UzU3NlVzUWhtTEQ1YWQxUi9HNk9naEZnc09ZTWlyTFpidnBSY3FUYW55NGlz?=
 =?utf-8?B?WkVCTGRrUzVZYW1ZOFBRVVBjWmh3WkVrVHJWZENtUml1RkVtbjNNUXhuZXNO?=
 =?utf-8?B?R1kxL3M3SkZ0aFZBRE94VkZqYkg4WURTZllEUVV4RHNFOTNDNHg3U1pvcm9K?=
 =?utf-8?B?L09MUzR6bk1nRXZ5eHJFUDRZNjF1a1VTaWN5UStlS2g3ZkdBQXlvQWJxcW5z?=
 =?utf-8?B?N0ZHVEtYam9zSVFUYzZrR2R3MGgzQ0M4ekRPYlZEdGY5ODZEWkJOWWF2eExq?=
 =?utf-8?B?R25tN0RwRGpzQTB2SjZqNFk5WDZUVDJBby9DT043cHR4U1JUR1AxMDZ6U3lD?=
 =?utf-8?B?aVRneFNPMkFVb1U4MmxsTTZGeHpDWHlobjZSNTlsbXNwbkdzbVdpUkpkM3hi?=
 =?utf-8?B?VGYxNG5YN0dtejl6UXEyOFQzNmcrWXhkK0VkZTltQmxEdGRVVnY3SjNXL2NU?=
 =?utf-8?B?RmNGRm5XVGl0Y1pkZ2NtRCtGZ0JlVWw1Tm9SNzJkdE5RaG5nZThYRFpJd281?=
 =?utf-8?B?SVNnYXFzQWFNeVZsRUpxbkI0eDBGRWZlbnhmazlXM3hsV3QyKzFjd1pQbjll?=
 =?utf-8?B?OFR2KzNFSHo5bnByZjIvdGhpYThta00vaStycnhZalpmOEttWk9aMkVTc2dE?=
 =?utf-8?B?THBDWGJFdlBTQnB1aWw4L2sveC80STVkRjJteXU2RVZrclFBM3c5dDhrUWZo?=
 =?utf-8?B?bG1lMEloYzFNZTZhUHVBVDNZaWhjdU9PeDBFNmlOdUlsSFB6a3BpaVpFTlJi?=
 =?utf-8?Q?+91YY9gg7+c4M?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MnRkcmRtZzNXa1pER1dISkdTMFg2WTBvMUhnTE0vdFJXMm84WXhZU1dlTjNu?=
 =?utf-8?B?Z1g3eVM1YVYxRitzVGNEbzNGK3NtdXRlak1IMG1Va2RUYTBLVzltZG5ldHZY?=
 =?utf-8?B?aUxxV1dPMSt4bGFuYnJOOThibHhTVXhQdmlJbkt1ak82ekRDb0Y3cFlZQnN2?=
 =?utf-8?B?aW5ZNzNvQ2VRWjg0RDhoY1p2dUpnVG9ZMW01T010SkVkRUxhbWJLZFpUQlJz?=
 =?utf-8?B?MFFweHlRcUo4R3ZLUUh4d0loUW03QUZSZjJqcmJocFNzR01mWkJMbVViVDNY?=
 =?utf-8?B?eXN6blliekJwcXBuL09OOW85WUJSZnlGZXhrak82cjBSaWFnd2JLa1dnR1pO?=
 =?utf-8?B?YmZuMzB2MmU2YkNvSzBQZmV2bndQOTJtZXVZRDBYYitIRkZnSzZRcjJHUzlO?=
 =?utf-8?B?aUoyY3lYSWVBM0hLQ212YWc1MTVkUklYNkxablk5Zkh5bkxUWXBVcXNWbjkw?=
 =?utf-8?B?eTAwaDZqTFpTL3AwS3dWbUFUNVR2T0ZRc2x6Ykkrd1k3UUxUcUlEUW9hRDhI?=
 =?utf-8?B?MlZadjFWKzJhMCsvUHphWTVaQ0pHZldHZk5CeFZBMmhTRWl3OGNoOTBBdUtX?=
 =?utf-8?B?cVd6ak05M21GSUZkMGhvUnZQUjVDanRpdXR4Y3VUODh2RkNWaHB5MUVsN1ZQ?=
 =?utf-8?B?dW5jU205c3c2WkhKTXpMeFZGWlhaMzFJeUUzTFc4VkNpV00yS0l1cTJsL2xY?=
 =?utf-8?B?b0JyS3g2R2xaMGVNL2hmQTh2L2J5ci9abSsyVU9POHRtKzZhdEY2dCt4QkUr?=
 =?utf-8?B?ajRmOExiQmFyT2FtaDJBUS9lcjN4eDdUVk8vVnJwRmdNcmYrS0tRZk12U2dY?=
 =?utf-8?B?dkgzNzRXMkNzQitzS1RwRlJ0L1RoVUw1Y3Z6SDZycmdycHA4M2o0SVpZUktT?=
 =?utf-8?B?ZmozYkY0WnU5M3pJUzZOUnQzRERFRUtKcWdKMjBKc2M4SlBIblN0ZnM3NnlU?=
 =?utf-8?B?OG1xNDg3Nng0ZS9wSDcvNU9WVkFTT1VMOUxqRFpsaUd2d3B1SnIyMmptRWVu?=
 =?utf-8?B?WlVFNzA4V1Zsa1lMM1dKMmVEY2xVa1pWVThrMUR5eXhlV09LbGZwYVpXY0Rm?=
 =?utf-8?B?ZWozZDNlS0h1ZDUxOTZUWXlNRXE1c3NKWHVKbHBEYjQyT1NSY05VbENDbS9K?=
 =?utf-8?B?d2lRS2g1M2JHSXlJdHEvdGNrMFk1OUNKWGFzTFJ4d2xiNlFrdjNUUWc3czRs?=
 =?utf-8?B?bjU5RDZaTVZWem54M1RNZlo4WkEzS3dpRENYMmFoa3ViMVdBcHB3UUM5TzVj?=
 =?utf-8?B?bnVYaVZrdW1pc3JUanlFT1FuMTVBUkdnNVlEckxoWEhoL25SM0FKVjUybnhQ?=
 =?utf-8?B?K3RJVUFMNUUxaVk3Nm1QdWhPbUJoYW9pNUNad1M1cTFrQ3VyVzdmWnRCR1lV?=
 =?utf-8?B?ZmVSNWM1ekZkTFdmZDZicURIbUpWTUl0Y0p3d09BMGVwVzZXd0hvc3lkRzdq?=
 =?utf-8?B?R0puTTFFK1FDUXdCdFczeWZmUk9uZGpaaEdzeSs4cEtwM3pVY3l1N2hnNFBJ?=
 =?utf-8?B?SGh0blBwR0tEamV1VnJVQU40T0lCclNaM2hEWnRxVWZIV2VvelhtaWdoR2tq?=
 =?utf-8?B?a05rSmpKNUIxSlhKZ1QzMGIrUE5ZRzg4Z0V2b3ZIMWxCVkxkb3RqNFFpZVhj?=
 =?utf-8?B?b3lvY21LVzBhNnMzekg3QUkybmNldzVJRDJrYThkTGljRUlaTGZMa1dWeHN0?=
 =?utf-8?B?UVpaaC9lcG1NN0lpdHdQYWdmWFJXbkJja0lqZEtnUkJkWklvT0N0U3dWU0RZ?=
 =?utf-8?B?cDd2VFJuT213L2oyeUl5djRsYzRCUXZja0E3YmNsMWdRR2J3UWpWOGlzSzlo?=
 =?utf-8?B?TkZpZ2xMQnVjSDNZb1dZcWcyTjk1cGszYVVhQ1FZNlJZeXArSTlzWjlmYlJk?=
 =?utf-8?B?RHdpNmRDWTc4WDk2REtTNENHUllxVFlGYU9JVUJZK3JzS1F4YzRsdGE3SWcr?=
 =?utf-8?B?bG1ndUtXOW5ZOHAyZGRhK05iakR3WG94ZysvL1ltT2daNGQyQitUZ0FmM0VR?=
 =?utf-8?B?WTZaZkZXZzNyKzNpL0srT0ErSmhVWEZYVFVUV0RZNFlQcEoxbWVpMW1XN2dB?=
 =?utf-8?B?c0djUWFoRm5pS0d3WWczNEtrT2szZEoyNStHYUJUdGxOZHFUWVJ6M1lUWFFG?=
 =?utf-8?B?OG1xbmE5bzRUZ3NXSmg3WjZFQWUyQW0yeFFCSzk2d2FMNU5TQk1aa3paYXBv?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b027ebf4-d990-4289-211e-08dd6209f99b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 08:35:13.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsvPnR6sA/qvfAdZeKf4mI14PidxCJoEpQsWuV3U5zgMW5pDiHaLntdQl5PZjPLsPWqJTqAIgY9NG2AVsBhI8RAIljv8FOIwFdajgI4fEuZrPCN7WL01SpT8aIJfiOLn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6540
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 08:35:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18185

SGkgSmFuLA0KDQpJIGNhbiBub3QgYXR0ZW5kIHRvZGF5J3MgbWVldGluZy4NCg0KPiAqIEFjdGlv
biBpdGVtcw0KPiAgIC0gc2hhcmUgcmVsZWFzZSBzY3JpcHRzL3Byb2NlZHVyZXMgW3BhdmVsLCBp
d2FtYXRzdS1zYW5dDQoNCk5vIHVwZGF0ZSBmcm9tIG1lLg0KDQo+ICogS2VybmVsIG1haW50ZW5h
bmNlIHVwZGF0ZXMNCg0KSSBhbSByZXZpZXdpbmcgNi4xLjEzMC4NCg0KPiAqIEtlcm5lbCByZWxl
YXNlIHN0YXR1cyBbKl0NCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAqIEFPQg0KPiAgIC0gYmFja3Vw
IGhvc3QgZm9yIG1lZXRpbmcgb24gTWFyY2ggMjANCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGly
bw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24NCj4gQmVo
YWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50OiBUaHVy
c2RheSwgTWFyY2ggMTMsIDIwMjUgNToxMiBQTQ0KPiBUbzogY2lwLWRldiA8Y2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmc+DQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBDSVAgSVJDIHdlZWtseSBt
ZWV0aW5nIHRvZGF5IG9uIGxpYmVyYS5jaGF0DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBLaW5kbHkg
YmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRoZSB3ZWVrbHkgbWVldGluZyB0aHJvdWdoIElSQyB0byBk
aXNjdXNzDQo+IHRlY2huaWNhbCB0b3BpY3Mgd2l0aCBDSVAga2VybmVsIHRvZGF5LiBPdXIgY2hh
bm5lbCBpcyB0aGUgZm9sbG93aW5nOg0KPiANCj4gICAgIGlyYzppcmMubGliZXJhLmNoYXQ6NjY2
Ny9jaXANCj4gDQo+IFRoZSBJUkMgbWVldGluZyBpcyBzY2hlZHVsZWQgdG8gVVRDIChHTVQpIDEz
OjAwOg0KPiANCj4gaHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVldGlu
Z2RldGFpbHMuaHRtbD95ZWFyPTIwMjUmDQo+IG1vbnRoPTMmZGF5PTEzJmhvdXI9MTMmbWluPTAm
c2VjPTAmcDE9MjI0JnAyPTE3OSZwMz0xMzYmcDQNCj4gPTM3JnA1PTI0MSZwNj0yNDgNCj4gDQo+
IFVTV2VzdCAgICBVU0Vhc3QgICAgVUsgICAgICAgIERFICAgICAgICBUVyAgICAgICAgSlANCj4g
MDY6MDAgICAgIDA5OjAwICAgICAxMzowMCAgICAgMTQ6MDAgICAgIDIxOjAwICAgICAyMjowMA0K
PiANCj4gTGFzdCBtZWV0aW5nIG1pbnV0ZXM6DQo+IGh0dHBzOi8vaXJjYm90LndsLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWVldGluZ3MvY2lwLzIwMjUvMDMvY2lwLjIwMjUtMDMtMDYtDQo+IDEzLjAy
LmxvZy5odG1sDQo+IA0KPiAqIEFjdGlvbiBpdGVtcw0KPiAgIC0gc2hhcmUgcmVsZWFzZSBzY3Jp
cHRzL3Byb2NlZHVyZXMgW3BhdmVsLCBpd2FtYXRzdS1zYW5dDQo+ICogS2VybmVsIG1haW50ZW5h
bmNlIHVwZGF0ZXMNCj4gKiBLZXJuZWwgcmVsZWFzZSBzdGF0dXMgWypdDQo+ICogS2VybmVsIHRl
c3RpbmcNCj4gKiBBT0INCj4gICAtIGJhY2t1cCBob3N0IGZvciBtZWV0aW5nIG9uIE1hcmNoIDIw
DQo+IA0KPiBKYW4NCj4gDQo+IFsqXQ0KPiBsaW51eC00LjQueS1jaXA6IGludGVydmFsIDMwIGRh
eQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVGh1IEZlYiAxMyAwNzo1MjozMiBB
TSBVVEMgMjAyNQ0KPiAgIGxpbWl0IGRhdGU6IFNhdCBNYXIgMTUgMDc6NTI6MzIgQU0gVVRDIDIw
MjUNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTQuNC55LWNpcC1ydDogaW50ZXJ2YWwg
NjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUdWUgRmViIDE4IDA4OjIx
OjI5IEFNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogU2F0IEFwciAxOSAwODoyMToyOSBBTSBV
VEMgMjAyNQ0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNC4xOS55LWNpcDogaW50ZXJ2
YWwgMzAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUdWUgTWFyIDExIDA5
OjEzOjQyIEFNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogVGh1IEFwciAxMCAwOToxMzo0MiBB
TSBVVEMgMjAyNQ0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNC4xOS55LWNpcC1ydDog
aW50ZXJ2YWwgNjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUdWUgSmFu
IDE0IDExOjQxOjE1IEFNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogU2F0IE1hciAxNSAxMTo0
MToxNSBBTSBVVEMgMjAyNQ0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNS4xMC55LWNp
cDogaW50ZXJ2YWwgMzAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUaHUg
RmViIDEzIDEwOjAxOjM0IFBNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogU2F0IE1hciAxNSAx
MDowMTozNCBQTSBVVEMgMjAyNQ0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNS4xMC55
LWNpcC1ydDogaW50ZXJ2YWwgNjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRl
OiBUdWUgSmFuIDI4IDAyOjQ1OjU1IFBNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogU2F0IE1h
ciAyOSAwMjo0NTo1NSBQTSBVVEMgMjAyNQ0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgt
Ni4xLnktY2lwOiBpbnRlcnZhbCAxNSBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRh
dGU6IFdlZCBNYXIgIDUgMDU6MDU6MDkgQU0gVVRDIDIwMjUNCj4gICBsaW1pdCBkYXRlOiBUaHUg
TWFyIDIwIDA1OjA1OjA5IEFNIFVUQyAyMDI1DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51
eC02LjEueS1jaXAtcnQ6IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVh
c2UgZGF0ZTogRnJpIEZlYiAxNCAwNToyNDozMCBQTSBVVEMgMjAyNQ0KPiAgIGxpbWl0IGRhdGU6
IFN1biBNYXIgMTYgMDU6MjQ6MzAgUE0gVVRDIDIwMjUNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo=


