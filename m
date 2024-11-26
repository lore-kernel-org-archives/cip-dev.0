Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41CDD5A6D5
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 03:18:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.37805.1732591114595631845
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Nov 2024 19:18:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4AQ3IV6M377574; Tue, 26 Nov 2024 12:18:31 +0900
X-Iguazu-Qid: 2yAaFOVUGbCaF4i4zs
X-Iguazu-QSIG: v=2; s=0; t=1732591110; q=2yAaFOVUGbCaF4i4zs; m=xpdGs052F7mf03bRhnJJTT8O4w8DYbOySDVeVCjulkE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 4AQ3IT6N698678
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 12:18:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsINHQgAAnKOxAz+9ncjQQMcoYi8D8ZCWfpxfYEdBAiTOY5xw6D23u8wdbfDOWkeFGCWpPqpfShA4yBV+WgbDAcOdy7VorQXF1pyT0LP18DmGTIOFlc7u5XNT141bwQ/y2L2uRvu/BlGk+ZB9Su5DevluCctmZ29nD2ZrLU7iQIApd0icaVX/e7kE7OZC5JC4MivdUX5emHHnjXxseYTth0qDMWiPW9pwDWFQA7CwmheI8tt4JsgsxAWLWI9DzfoZCr/yd9AxLjKt5YNttHunAUQSuZlUyYrtXrgvgojNBFFQOqwH7hc0J4dskZCpCNEY4TjQcaXEzrEHv8deTp1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/l9i20H+V5EekmApbrHQetBX2DGTP8LVgrp+V7MDzQ=;
 b=ucGtzcfNAv2mcuGU7TJvrxvu6CarQkafOlRs5/eZ6YH9cpWE9MiKf5iuY0ygk/FoE1S89Np3L2AcbIqr1B8dt8Yb29CssVG/71ZMkg4DvQE9c7rModzj2CDCgvQI5LIYkFeDYKM/RzSYD//YkAAZpuAKaWIRu9Snc/8rZICk8QBeWosNIp0M/Yzgw/4tBUX8zWuNpBax3uG/zyRLmhSkAx4mKzfRcHGH7tX+RkznTuF025W1GazKK4ERwPkFLjGOL0yGZmcfxcM9NDsxcQ/bL8Hwo+hgiNG+2BjX7Z4UigLhMucp/TF7fS62taWFkRcx/XrrwkG5JjPWdu4T/LgiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <dinesh.kumar@toshiba-tsip.com>,
        <cip-security@lists.cip-project.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x86 and
 generate results
Thread-Topic: [cip-dev] Manually run Kernel and IEC tests on M-COM x86 and
 generate results
Thread-Index: AQHbNLcv3vC8deZB0Ua07zkQ6b5nXrKzrb4QgASohfaACXHRW4AGb/wQgADAbzg=
Date: Tue, 26 Nov 2024 03:18:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61038562D6A34A0313834A60C22F2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB1240281691D569EB3FFF1BF46B7592@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <1808283AFE02050D.20097@lists.cip-project.org>
 <OS3PR01MB6103A8419829A8FDDCC767FDC2222@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB124029C5A19C30B588BCFB6DFB72E2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYYPR01MB124029C5A19C30B588BCFB6DFB72E2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYWPR01MB9662:EE_
x-ms-office365-filtering-correlation-id: 4cc41e33-0cc0-48c9-fb7e-08dd0dc8fdcc
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?ks_c_5601-1987?B?RUZnWGdRWDJhOHpuc0RWeXFCSVNPV0YwaVpxMndtL2tndEk2Y05T?=
 =?ks_c_5601-1987?B?Y0xWQTlzWW56SVdYTW1OdldSdzE4T2dZSFFlaS9YK2dYZHpsMXJU?=
 =?ks_c_5601-1987?B?M3F3eFNka01hSDVIUi9UUjhPdm1WSjBNbTRVRkhlUDZqQXgzeWUr?=
 =?ks_c_5601-1987?B?ZTFrdlBOSk9XTzZJTWJ6R0hvUG1LOGdXRklBOExKOXRrcUJNcjVY?=
 =?ks_c_5601-1987?B?aHpBdGJiMDNZdXVSRW9iRVdjaXJXVXlqdUxBSDJPSnBxOXE5S0NF?=
 =?ks_c_5601-1987?B?Nldjd09nb1FqWVJ4ZkdnU25XTk9vZ1FicWVYeW1MNnZob2E3RW9t?=
 =?ks_c_5601-1987?B?d2FRaHE0TGZ6UmppWHVuWEVDeVhLbGpSd2loZDUrSnphYks0ZHpn?=
 =?ks_c_5601-1987?B?MWs5SVdXejM5cHpmakMzN1F1S1JYb0k1Ti9IUHhNUEpoaW1VK0NG?=
 =?ks_c_5601-1987?B?c3RUdkRYSFZobXZWV0dhT1RpM0lFbGZCQ1lqR0wzVklrMGR2RFk5?=
 =?ks_c_5601-1987?B?RHFSL21UbExXWk5rcnpXUUxTK3JmSTVxTlk5bW9PdXdNcUF0M3Jo?=
 =?ks_c_5601-1987?B?Nmk1NndGbUpCRFZsK0dUNUlFMmlIQlFVK0ttNWtaUzhJbzk4UDRF?=
 =?ks_c_5601-1987?B?aFhOU1lrRWFsYnVMNWl5bWhkSW1nNjRQUnd5WUlvbzhuU01aV3Fq?=
 =?ks_c_5601-1987?B?UmpjVjJiQ2NpcVU4YWhoeE1CTDlaNXJTQ1JhNEdGYWI1MnZuZy9p?=
 =?ks_c_5601-1987?B?VG9aSStvRjVhREtHWjNYdERqTk5IdDlBdTN0dFcrdzhtVTNvVWNs?=
 =?ks_c_5601-1987?B?dWQ4MjZ6WE5LYXBtSlN1M0JTYWJ5VFJzc2hoeEF6VUZRM0NMdGxu?=
 =?ks_c_5601-1987?B?WEFiOVRXaE5zRDNxKzdYcnpvSzZ1djZuMUxDc3VsMDBVS2NQa1BS?=
 =?ks_c_5601-1987?B?ank4UUZzUlV5cEpFdUxZNGlXM1dwM0R0UmFMQWJISFFKZytCaFVU?=
 =?ks_c_5601-1987?B?SEQ2UzlzdUl2REZMeGdQV2dKTFFUeFV2QlJDQzFNZmRoSzhreHJN?=
 =?ks_c_5601-1987?B?SkVtNzJIUnY3dWY1N2RZMFZXSXIwWWgyMi9Jb251aklrczc2UWN1?=
 =?ks_c_5601-1987?B?MndlelNMMDlueFEzVFJOMkp5N3NQMjlBeDBJRitPTFN4a1dNMXpY?=
 =?ks_c_5601-1987?B?aTFLbTlJb3FwdUJhd0JPT3NaQ05qOVYwcDg2eWpyYVk3dGFwblNo?=
 =?ks_c_5601-1987?B?V1cyNCtyQ1Q5TTRlblk0T0dTUktublcrTkdKS0ZMT1VUZ2lFVURQ?=
 =?ks_c_5601-1987?B?UjlrdVd1MnV2YndvdXAzUnlVVVMrcjR2L0pZMXRhamx4R0J4VVZI?=
 =?ks_c_5601-1987?B?aU1UZ2Y5aG4wRzlycjU3Z25IVnl1c3lDUWViNG1kNVdJb2V1ZXB6?=
 =?ks_c_5601-1987?B?eWtzNmsvblNMeVQ2UExiY1ZKMW9SU0QrYk5IazNKKzZlVVhma0Va?=
 =?ks_c_5601-1987?B?Y0pLWlQ2UVpRWXhPRzNGWTZPVkRJVVh4KzVuL2VzUTBKcWcwelo3?=
 =?ks_c_5601-1987?B?d3NmNm5tMzA0SEp0SVpSWEVtL1ZUV3IvSncxbFJVT2VMS2c3Z0ZH?=
 =?ks_c_5601-1987?B?Uk9reUlGeWVrVjdvem1KTzNGVHFNVUpPS0czSnNpLy82YUpiZWJ4?=
 =?ks_c_5601-1987?B?VjBueklrSnZUTTdyaFJjVE9rY3RVWC90S1FXZ0xrRUR5NVVodTdh?=
 =?ks_c_5601-1987?B?Q2M2VnIzelhkdUpTWC8rZmtQNmFVSnZiUkJxY08ydXdwSnNrazJE?=
 =?ks_c_5601-1987?B?VXo1TDhkbFhsR1QxZkVISlhIRFZTWUpJWWpsWTFFTlZVa09haEJM?=
 =?ks_c_5601-1987?B?WUE5WXQ0L2J4WXVJM3RMTitlNWc0elVqYmdSbVF5NEJLOHlCSy9i?=
 =?ks_c_5601-1987?B?SDltZ0xxTSs3VmtNRGhaa2dQTlZ4b1ZMLzZCamdEM0J0RFhTeGFq?=
 =?ks_c_5601-1987?B?dmc5S2tzZzg5TVZPTnhEY2FJL0ZRWmNFZXNtSGxTc1B4WnUyVlo5?=
 =?ks_c_5601-1987?B?SHBoTjJJY2VaYVd5VnFjdkxhR0xzR29KK0xNZ0k1NndrKyt0aE40?=
 =?ks_c_5601-1987?Q?J7zhnLoK45xdJuyecgn5kA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?ks_c_5601-1987?B?aFZXN1VTMDVjTklubXJNSWxxRUd4b09OTm1VMEpyeWxxWFZGVDNB?=
 =?ks_c_5601-1987?B?eWE1YVJJdVZPYWNrL0gxYkZleFFVUnlHWW5tYThLSGNsZGZzTGJQ?=
 =?ks_c_5601-1987?B?ZHRTS1dwMXZsT2FqMDdEZTBOS1Nlc3VPc3d4dEtlSXVOWVcyODRi?=
 =?ks_c_5601-1987?B?cHlZYU1xb1FHMjcrZ1JjaDlUN3R0d1o2YWhqc3pKN01SeVlWSTZ6?=
 =?ks_c_5601-1987?B?ZFYyaHRRVjVQdW14QlVMakhvRG9yWlpIN29LbHpPbmF0WmpybHAw?=
 =?ks_c_5601-1987?B?cXZSUHFwbDRVWHRLZzZHNWJ5TXFRcGxHbXZ1ZmwvZ3Z5NC8yQnpt?=
 =?ks_c_5601-1987?B?c1JWUExUS0xiSjlUdHNkSmd3dm81cUNNM0xWRzdlbUd1VkFEMERv?=
 =?ks_c_5601-1987?B?dllzYkFVMGc1VzQ2RGJmcklRbmJCR2R3V3U1eFk2bnFiQ3pxZjBR?=
 =?ks_c_5601-1987?B?Y1JEMXQ5RjhQcWxBOXh2ODZ4eTE4NGNYazlXRG5LUWR5djhFYnI0?=
 =?ks_c_5601-1987?B?YlhiM1VwdDJWRGtINnNFSFVmVTFpQjBEaFM4SENINGZ3NHZZYk5m?=
 =?ks_c_5601-1987?B?b1J2YnV2cXh4MXhxWTF5WHJUc01kN09LUDBVbDRqS0NrNXprV1V5?=
 =?ks_c_5601-1987?B?SGRpeC9BaHdqNVBtdWNMSzhiRmlDN3k0UElxdUlRUkhJSllHOWRi?=
 =?ks_c_5601-1987?B?RCtEYTJhMEg5NnQvZ0hld2NtbG1qbklqcUdidGFZeEVlelpnUGx0?=
 =?ks_c_5601-1987?B?OTVjcG4xeHltZGVUQmJFS0VWbVhvZXNQdlZHR2RsSjQxVGFNejA1?=
 =?ks_c_5601-1987?B?bHowU2Z4VjRnVkJiU2tGNzlFTkh4S2hQeGh5SytZNGFScEZYOWdI?=
 =?ks_c_5601-1987?B?Y1VUUEVmdkhtSGxROHdaSFdhZ2pnU3lZbGpEb3ozVmpFWGFoTEJk?=
 =?ks_c_5601-1987?B?ZnJrZ0dRMnVLeGJIMDIxdEpsVFVwVFF3N0JIVWNpVkNtQ1FhZ1ky?=
 =?ks_c_5601-1987?B?S1dWbTJxY1hyZURHa25UOUtubTVuR2pFUmp4YktLazVUTCtIRFRH?=
 =?ks_c_5601-1987?B?d1krckI5WEsvU1BlalVpWncrdWt5cXlwdFhUUncydkNHeXJjcCtP?=
 =?ks_c_5601-1987?B?TlM0OVRzSjh4eTVWSVRyeE5naW12aDFzRTljd09FMkNGRE84NGY2?=
 =?ks_c_5601-1987?B?emtYblB2bFM0ZVhic1pORythNkIwVHRaWWFlclovdXJia2xZLzVB?=
 =?ks_c_5601-1987?B?T0ZyOHRzbG5tU3hadWo3SnV1c2pycmNRRnZvazFQTDVXMHVyT0pE?=
 =?ks_c_5601-1987?B?elozTzJBUXlWTHAwc1FZeHlja0pGMzQ0bnR5NVNjR3VqeTBQTUlI?=
 =?ks_c_5601-1987?B?cTZrTlJDWUZWY1E3cElYUUU1VW1WQWJrNEY2MkNiR1p4NVZKOHd0?=
 =?ks_c_5601-1987?B?T3lUTzQyYTIyYUdQRU9yQVJQZEZ0LzVPaVpPM0xiTVQ1VUR0VGI3?=
 =?ks_c_5601-1987?B?RzNvMlNOblMzY2YzNU9acUtIRUd5RkpjV3hlZW5DeWI0dFQ4Y1hG?=
 =?ks_c_5601-1987?B?SVFlRXJyOEZuYXJNV0d5eXZScU0rZ3l6UU9iT09GVmRkUkNGNTJa?=
 =?ks_c_5601-1987?B?NXZQTWpUNG1ZMzJaQW1WUFBWYXhnYS8vYitXb011RjlGb285Z0VZ?=
 =?ks_c_5601-1987?B?bFBpOWhaZko2VlZEK0lQYmwwb05kWDhWM1J0UkRDbDNreHhEa0lD?=
 =?ks_c_5601-1987?B?ZkkzVXRHdkR6d0pOVndIMTg5bGNGbVZTcWk5U1UyVEt2VWZ5NkJi?=
 =?ks_c_5601-1987?B?OWM3dFBGOHVZUEVOaHptMWsyMzdTaTZHZVExSTBhTTNON29EQUhX?=
 =?ks_c_5601-1987?B?RStwU09FMEthTzd6bkg2WjlzRXVaZXl4NTdiQ1Y4R0ZLeVgyQnVZ?=
 =?ks_c_5601-1987?B?NnJNbE9ZVjVibGxMUkhmWE94bzFsZmtDOUJXdFg2b1NQSEo0UTZs?=
 =?ks_c_5601-1987?B?TFZNYitlcGRyQjZwek9RZmkrZVRBNGdsUUd3VHRBU2h0V21hak5q?=
 =?ks_c_5601-1987?B?cWFiaTJyYzZIeFNOa3RQUlRiQllTaVFoem9IZWxtQ2lDREVDMW9l?=
 =?ks_c_5601-1987?B?dVhsWDRTTnZHczNEWk5IcENBbHRidHAyYXA1YjBPdUtvaWYxWGhT?=
 =?ks_c_5601-1987?B?d3J1eXBqUUNXNXJHelBVdnlOWExVc3QxZVN4YnJyMnBkU01ndjhx?=
 =?ks_c_5601-1987?B?Q1FYM2JhSDVQMVd5bjlrc0ljTCtZRXpRSXZqLzA4cGxQVUU5Vk10?=
 =?ks_c_5601-1987?B?Z25ZR0RQbW5FQ3hYeUdEKzhadlM4RVkwSnh3cDZUUVZuL1NkQWlk?=
 =?ks_c_5601-1987?B?TnhNQ2FhcWVGejFMTmg5M3ljc3psaXFWTEdrNFFEaDlscjBFNWFV?=
 =?ks_c_5601-1987?B?NWhPRE5yam5JREplb0NpU2tKRi9MSGtXSi9Xa1V4bEw0QTErUmZN?=
 =?ks_c_5601-1987?B?OU5VMG1zWXhqVHRJL2orQXppUFg2cGc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61038562D6A34A0313834A60C22F2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc41e33-0cc0-48c9-fb7e-08dd0dc8fdcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 03:18:25.8605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+StykxSUFTSjN5itqNecAhqPztK5zKjf/K8E0Fwh8T/SaVfLzgyAgaIshWbTo1wxo26S9Fu+YvjpcEFreinYTk5+jmCCBtaowlr3q5EwHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9662
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Nov 2024 03:18:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17277

--_000_OS3PR01MB61038562D6A34A0313834A60C22F2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

SGVsbG8gQ2hyaXMsDQoNCkhvcGUgeW91IGFyZSBkb2luZyB3ZWxsLg0KDQpJIGhhdmUgY3JlYXRl
ZCBhIGN1c3RvbSBicmFuY2ggaW4gaXNhci1jaXAtY29yZSBmcm9tIHdoaWNoIEkgY3JlYXRlZCBh
IHg4NiBnZW5lcmljIHVlZmkgcm9vdGZzIHRhcmJhbGwgd2l0aCBMVFAgYmluYXJ5IGluc3RhbGxl
ZCwgaHR0cHM6Ly9zMy1ldS1jZW50cmFsLTEuYW1hem9uYXdzLmNvbS9kb3dubG9hZDIuY2lwLXBy
b2plY3Qub3JnL2NpcC1jb3JlL3NhaS1kZXBsb3kteDg2dWVmaS1yb290ZnMtbHRwL3g4Ni11ZWZp
L2NpcC1jb3JlLWltYWdlLWNpcC1jb3JlLWJvb2t3b3JtLXg4Ni11ZWZpLXRlc3QudGFyLmd6DQoN
CkkgcmFuIExUUCB0ZXN0cyBvbiBNLUNPTSBvbiBMQVZBIGZvciA2LjEuMTE1LWNpcDMxLg0KDQpQ
bGVhc2UgaGF2ZSBhIGxvb2sgYXQgdGhlIGxpc3Qgb2Ygam9icyByYW4gcmVjZW50bHkgb24gTS1D
T00gTEFWQSB8IFNjaGVkdWxlciB8IERldmljZSBUeXBlcyB8IHg4Ni1zaWVtZW5zLW1jb208aHR0
cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9kZXZpY2VfdHlwZS94ODYtc2llbWVu
cy1tY29tPg0KDQpUaGFua3MgYW5kIHJlZ2FyZHMsDQpTYWkgQXNocml0aCAoVCBTIEkgUCkNCg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IENocmlzIFBhdGVyc29uIDxD
aHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+DQpTZW50OiBNb25kYXksIE5vdmVtYmVyIDI1LCAy
MDI0IDk6MTcgUE0NClRvOiBhc2hyaXRoIHNhaSij1KPTo8mj0CkgPFNhaS5TYXRodWpvZGFAdG9z
aGliYS10c2lwLmNvbT4NCkNjOiBoYXlhc2hpIGthenVoaXJvKNf5IPv6ztsgo8SjzaPFIKHbo8Sj
yaPHoeCjzaPQo9Oh26PNo9CjtCkgPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+OyBk
aW5lc2gga3VtYXIoo9Sj06PJo9AgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9z
aGliYS10c2lwLmNvbT47IGNpcC1zZWN1cml0eUBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1z
ZWN1cml0eUBsaXN0cy5jaXAtcHJvamVjdC5vcmc+OyBpd2FtYXRzdSBub2J1aGlybyjk2+HmIOPh
5ccgodujxKPJo9Sjw6Hgo8SjyaPUodujz6PTo9QpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGli
YS5jby5qcD47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZz4NClN1YmplY3Q6IFJFOiBbY2lwLWRldl0gTWFudWFsbHkgcnVuIEtlcm5l
bCBhbmQgSUVDIHRlc3RzIG9uIE0tQ09NIHg4NiBhbmQgZ2VuZXJhdGUgcmVzdWx0cw0KDQoNCkhl
bGxvIFNhaSwNCg0KDQoNCkFwb2xvZ2llcyBmb3IgdGhlIHNsb3cgcmVzcG9uc2UuDQoNCg0KDQpX
ZWxsIGRvbmUgZm9yIGdldHRpbmcgdGhlIExUUCB0ZXN0cyBydW5uaW5nIGxvY2FsbHkuDQoNCklm
IHlvdSBzZW5kIG1lIHRoZSB0YXJiYWxsIG9yIGxpbmsgbWUgdG8gaXQgSSBjYW4gdXBsb2FkIGl0
IHRvIFMzIGZvciB5b3UuDQoNCg0KDQpLaW5kIHJlZ2FyZHMsIENocmlzDQoNCg0KDQpGcm9tOiBT
YWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20gPFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lw
LmNvbT4NClNlbnQ6IDIxIE5vdmVtYmVyIDIwMjQgMTM6MzgNClRvOiBDaHJpcyBQYXRlcnNvbiA8
Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPg0KQ2M6IGthenVoaXJvMy5oYXlhc2hpQHRvc2hp
YmEuY28uanA7IGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tOyBjaXAtc2VjdXJpdHlAbGlz
dHMuY2lwLXByb2plY3Qub3JnOyBub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcDsgY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gTWFudWFs
bHkgcnVuIEtlcm5lbCBhbmQgSUVDIHRlc3RzIG9uIE0tQ09NIHg4NiBhbmQgZ2VuZXJhdGUgcmVz
dWx0cw0KDQoNCg0KSGVsbG8gQ2hyaXMsDQoNCg0KDQpIb3BlIHlvdSBhcmUgZG9pbmcgZ3JlYXQu
DQoNCg0KDQpUaGlzIGlzIGp1c3QgYW4gdXBkYXRlIHJlZ2FyZGluZyBteSBwcmV2aW91cyBxdWVy
eSBpbiB0aGlzIG1haWwgdGhyZWFkLg0KDQoNCg0KSSB3YXMgYWJsZSB0byBydW4gTFRQIG9uIHNl
Y3VyaXR5IHRhcmdldCBpbiBteSBtYWNoaW5lIGFmdGVyIGluY2x1ZGluZyBrYXMvb3B0L3Rlc3Qu
eW1sIKGkIG1hc3RlciChpCBjaXAtcHJvamVjdCAvIGNpcC1jb3JlIC8gaXNhci1jaXAtY29yZSCh
pCBHaXRMYWI8aHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lw
LWNvcmUvLS9ibG9iL21hc3Rlci9rYXMvb3B0L3Rlc3QueW1sP3JlZl90eXBlPWhlYWRzPiB3aGls
ZSBidWlsZGluZyB0aGUgaW1hZ2UgYXMgaXQgY29tZXMgYWxsIHRoZSBkZXBlbmRlbmNpZXMgcmVx
dWlyZWQgdG8gcnVuIHRoZW0uDQoNCg0KDQpGb3IgTEFWQSwgSSB3aWxsIHRyeSB0byB1cGxvYWQg
YSByb290ZnMgdGFyYmFsbCB0byBjaXAtcHJvamVjdCdzIFMzIHN0b3JhZ2Ugd2l0aCBidWlsZDp4
ODYtdWVmaS1iYXNlIGNvbmZpZ3VyYXRpb24gYWxvbmcgd2l0aCBleHRlbnNpb246IHRlc3QuIEkg
aG9wZSBJIGNhbiBydW4gTFRQIHRlc3RzIG9uIE0tQ09NIHg4NiBvbiBMQVZBIHdpdGggdGhpcyBt
ZXRob2QuIEkgcmFuIFNNQyB0ZXN0cyBvbiBNLUNPTSB4ODYgd2l0aCA2LjEuMTEyLWNpcDMwIGtl
cm5lbCAtPiBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvcmVzdWx0cy8xMjIyNjE2LzBfc3Bl
Y3RyZS1tZWx0ZG93bi1jaGVja2VyLXRlc3QNCg0KDQoNClRoYW5rcyBhbmQgcmVnYXJkcy4NCg0K
U2FpIEFzaHJpdGgNCg0KDQoNCg0KDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCg0KRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnPiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFp
bHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPj4gb24gYmVoYWxmIG9mIHNhaS5zYXRo
dWpvZGFAdG9zaGliYS10c2lwLmNvbTxtYWlsdG86c2FpLnNhdGh1am9kYUB0b3NoaWJhLXRzaXAu
Y29tPiA8c2FpLnNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPG1haWx0bzpzYWkuc2F0aHVqb2Rh
QHRvc2hpYmEtdHNpcC5jb20+Pg0KU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxNSwgMjAyNCA3OjE0
IFBNDQpUbzogQ2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPG1haWx0bzpDaHJpcy5QYXRlcnNv
bjJAcmVuZXNhcy5jb20+IDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb208bWFpbHRvOkNocmlz
LlBhdGVyc29uMkByZW5lc2FzLmNvbT4+DQpDYzogaGF5YXNoaSBrYXp1aGlybyjX+SD7+s7bIKPE
o82jxSCh26PEo8mjx6Hgo82j0KPTodujzaPQo7QpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJh
LmNvLmpwPG1haWx0bzprYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPj47IGRpbmVzaCBr
dW1hciij1KPTo8mj0CBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRz
aXAuY29tPG1haWx0bzpkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT4+OyBjaXAtc2VjdXJp
dHlAbGlzdHMuY2lwLXByb2plY3Qub3JnPG1haWx0bzpjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXBy
b2plY3Qub3JnPiA8Y2lwLXNlY3VyaXR5QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzxtYWlsdG86Y2lw
LXNlY3VyaXR5QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4+OyBpd2FtYXRzdSBub2J1aGlybyjk2+Hm
IOPh5ccgodujxKPJo9Sjw6Hgo8SjyaPUodujz6PTo9QpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9z
aGliYS5jby5qcDxtYWlsdG86bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+PjsgY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnPiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnPj4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gTWFudWFsbHkgcnVu
IEtlcm5lbCBhbmQgSUVDIHRlc3RzIG9uIE0tQ09NIHg4NiBhbmQgZ2VuZXJhdGUgcmVzdWx0cw0K
DQoNCg0KSGVsbG8gQ2hyaXMsDQoNCg0KDQpIb3BlIHlvdSBhcmUgZG9pbmcgd2VsbC4NCg0KDQoN
CkFmdGVyIGdvaW5nIHRocm91Z2ggTGF2YSBqb2IgZGVmaW5pdGlvbnMgd2hlcmUgbHRwIHRlc3Rz
IGFyZSBydW4gb24gQ0lQIHJlZmVyZW5jZSBoYXJkd2FyZSBvbiBDSVAgTEFWQSwNCg0KDQoNCkkg
bm90aWNlZCB0aGF0IGx0cCB0ZXN0cyBhcmUgYmVpbmcgbW9zdGx5IG9uOg0KDQoNCg0KcmVuZXNh
c19yOGE3NzQzLWl3ZzIwZC1xNw0KDQpyZW5lc2FzX3I4YTc3NGExLWhpaG9wZS1yemcybS1leA0K
DQp4ODZfY2lwX3FlbXUNCg0KDQoNClVzaW5nIHJvb3RmcyB0YXJiYWxscyBzdWNoIGFzOg0KDQoN
Cg0KaHR0cHM6Ly9zMy1ldS1jZW50cmFsLTEuYW1hem9uYXdzLmNvbS9kb3dubG9hZDIuY2lwLXBy
b2plY3Qub3JnL2NpcC10ZXN0aW5nL2xhdmEtaGVhbHRoY2hlY2tzL3Jmcy9jb3JlLWltYWdlLW1p
bmltYWwtcWVtdWFybTY0LWx0cC50YXIuYnoyDQoNCmh0dHBzOi8vczMtZXUtY2VudHJhbC0xLmFt
YXpvbmF3cy5jb20vZG93bmxvYWQyLmNpcC1wcm9qZWN0Lm9yZy9jaXAtdGVzdGluZy9sYXZhLWhl
YWx0aGNoZWNrcy9yZnMvY29yZS1pbWFnZS1taW5pbWFsLXFlbXV4ODYtNjQtbHRwLmV4dDQueHoN
Cg0KDQoNCi4uYWxvbmcgd2l0aCByZXNwZWN0aXZlIGR0YiBmaWxlcy4NCg0KDQoNCkJ1dCBjdXJy
ZW50bHkgbS1jb20gaGVhbHRoIGNoZWNrcyBhcmUgdXNpbmcgaHR0cHM6Ly9zMy11cy13ZXN0LTIu
YW1hem9uYXdzLmNvbS9kb3dubG9hZC5jaXAtcHJvamVjdC5vcmcvY2lwdGVzdGluZy9jaXAtbGF2
YS9yZnMvcm9vdGZzLXNpbWF0aWMtaXBjMjI3ZS50YXIuZ3ogcm9vdGZzLg0KDQoNCg0KSSB0cmll
ZCB0byB1c2UgIFNLSVBfSU5TVEFMTDogImZhbHNlIiBpbiB0aGUgdGVzdCBkZWZpbml0aW9uIGJl
Y2F1c2UgbHRwIHRlc3QgY2FzZXMgYXJlIG5vdCBwcmVzZW50IGluIGV4cGVjdGVkIGZvbGRlcnMs
IGV4OiAvb3B0L2x0cCBhbmQgZGVwZW5kZW5jeSBwYWNrYWdlcyBhcyB3ZWxsIGV4cGVjdGluZyB0
aGV5IHdpbGwgYmUgaW5zdGFsbGVkIGluIHRoZSBpbWFnZSBhZnRlciBib290LiBCdXQgdGhlIGpv
YiBmYWlsZWQuIGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzEyMjMx
NDkjTDEzMzkNCg0KDQoNCkkgcmVxdWVzdCB5b3UgdG8gaGVscCBtZSBpbiBwcmVwYXJpbmcgYSBz
aW1hdGljLWlwYzIyN2Ugcm9vdGZzIHRhcmJhbGwgd2l0aCBsdHAgdGVzdHMgYW5kIHJlcXVpcmVk
IHBhY2thZ2VzIGFuZCBwdXNoaW5nIGNpcC1wcm9qZWN0IHMzIHN0b3JhZ2Ugc28gdGhhdCBJIGNh
biBydW4gbHRwIHRlc3RzIG9uIG0tY29tIGRldmljZS4gUGxlYXNlIHN1Z2dlc3QgaWYgeW91IGtu
b3cgYW55IGFsdGVybmF0ZSByb290ZnMgY2FuIGJlIHVzZWQgdG8gYm9vdCBvbiBtLWNvbSBkZXZp
Y2UuDQoNCg0KDQpUaGFua3MgYW5kIHJlZ2FyZHMsDQoNClNhaSBBc2hyaXRoDQoNCg0KDQpodHRw
czovL3MzLWV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tL2Rvd25sb2FkMi5jaXAtcHJvamVjdC5v
cmcvY2lwLXRlc3RpbmcvbGF2YS1oZWFsdGhjaGVja3MvcmZzL2NvcmUtaW1hZ2UtbWluaW1hbC1x
ZW11YXJtNjQtbHRwLnRhci5iejINCg0KaHR0cHM6Ly9zMy1ldS1jZW50cmFsLTEuYW1hem9uYXdz
LmNvbS9kb3dubG9hZDIuY2lwLXByb2plY3Qub3JnL2NpcC10ZXN0aW5nL2xhdmEtaGVhbHRoY2hl
Y2tzL3Jmcy9jb3JlLWltYWdlLW1pbmltYWwtcWVtdXg4Ni02NC1sdHAuZXh0NC54eg0KDQoNCg0K
DQoNCg0KDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KRnJvbTogY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnPiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnPj4gb24gYmVoYWxmIG9mIENocmlzIFBhdGVyc29uIHZpYSBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgPGNocmlzLnBhdGVyc29uMj1yZW5lc2FzLmNvbUBsaXN0cy5jaXAt
cHJvamVjdC5vcmc8bWFpbHRvOmNocmlzLnBhdGVyc29uMj1yZW5lc2FzLmNvbUBsaXN0cy5jaXAt
cHJvamVjdC5vcmc+Pg0KU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTIsIDIwMjQgNzozOSBQTQ0K
VG86IGNpcC1zZWN1cml0eUBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1zZWN1cml0
eUBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IDxjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qu
b3JnPG1haWx0bzpjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qub3JnPj47IGl3YW1hdHN1
IG5vYnVoaXJvKOTb4eYg4+HlxyCh26PEo8mj1KPDoeCjxKPJo9Sh26PPo9Oj1CkgPG5vYnVoaXJv
MS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPG1haWx0bzpub2J1aGlybzEuaXdhbWF0c3VAdG9zaGli
YS5jby5qcD4+DQpDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8bWFpbHRvOmNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc8
bWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPj47IGhheWFzaGkga2F6dWhpcm8o
1/kg+/rO2yCjxKPNo8UgodujxKPJo8eh4KPNo9Cj06Hbo82j0KO0KSA8a2F6dWhpcm8zLmhheWFz
aGlAdG9zaGliYS5jby5qcDxtYWlsdG86a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4+
OyBkaW5lc2gga3VtYXIoo9Sj06PJo9AgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJA
dG9zaGliYS10c2lwLmNvbTxtYWlsdG86ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+Pg0K
U3ViamVjdDogUmU6IFtjaXAtZGV2XSBNYW51YWxseSBydW4gS2VybmVsIGFuZCBJRUMgdGVzdHMg
b24gTS1DT00geDg2IGFuZCBnZW5lcmF0ZSByZXN1bHRzDQoNCg0KDQpIZWxsbyBTYWksDQoNCj4g
RnJvbTogY2lwLXNlY3VyaXR5QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzxtYWlsdG86Y2lwLXNlY3Vy
aXR5QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gPGNpcC1zZWN1cml0eUBsaXN0cy5jaXAtDQo8bWFp
bHRvOmNpcC1zZWN1cml0eUBsaXN0cy5jaXAtJTBiPj4gcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBP
ZiBzYWkgYXNocml0aCBzYXRodWpvZGEgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50
OiAxMiBOb3ZlbWJlciAyMDI0IDA0OjE0DQo+DQo+IEhlbGxvIENocmlzLA0KPg0KPiBIb3BlIHlv
dSBhcmUgZG9pbmcgd2VsbC4NCj4NCj4gUmVnYXJkaW5nIElFQyA2MjQ0My00LTIgY2VydGlmaWNh
dGlvbiwgdGhlIGNlcnRpZmljYXRpb24gYm9keSBoYXMgYXNrZWQNCj4gZm9yIEtlcm5lbCBhbmQg
SUVDIHRlc3QgcmVzdWx0cyBvbiBNLUNPTSBkZXZpY2UuIEJhc2VkIG9uIG15IGN1cnJlbnQNCj4g
a25vd2xkZWdlLCBJIGJlbGlldmUgdGhhdCB0aGUgdGVzdCBzdWl0ZXMgbWVudGlvbmVkIGhlcmUN
Cj4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5nL2xpbnV4LWNpcC1j
aS8tDQo+IC9ibG9iL21hc3Rlci9zdWJtaXRfdGVzdHMuc2g/cmVmX3R5cGU9aGVhZHMjTDU1IDxo
dHRwczovL2dpdGxhYi5jb20vY2lwLQ0KPGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtJTBiPj4gcHJv
amVjdC9jaXAtdGVzdGluZy9saW51eC1jaXAtY2kvLQ0KPiAvYmxvYi9tYXN0ZXIvc3VibWl0X3Rl
c3RzLnNoP3JlZl90eXBlPWhlYWRzI0w1NT4gIHNoYWxsIHJ1biBmb3IgZXZlcnkNCj4gdXBkYXRl
ZCBrZXJuZWwgaW1hZ2Ugb24gZGlmZmVyZW50IENJUCByZWZlcmVuY2UgaGFyZHdhcmUgaW4gTEFW
QS4NCj4NCj4gU2luY2UgYXZhaWxhYmlsaXR5IG9mIE0tQ09NIGRldmljZSBvbiBDSVAgTEFWQSBM
YWIgc3RpbGwgbmVlZHMgc29tZSB0aW1lLA0KPiB3ZSBhcmUgbWFudWFsbHkgcnVubmluZyBlYWNo
IHRlc3Qgc3VpdGUgaS5lIFNNQywgU21va2UsIExUUCBldGMuIGZyb20NCj4gaHR0cHM6Ly9naXRo
dWIuY29tL2tlcm5lbGNpL3Rlc3QtZGVmaW5pdGlvbnMNCg0KQXMgSmFuIHNhaWQgLSB3ZSBub3cg
aGF2ZSBvbmUgaW4gQ0lQJ3MgTEFWQS4NCklmIHlvdSBoYXZlIGlzc3VlcyB1c2luZyBpdCBwbGVh
c2UgbGV0IG1lIGtub3cuDQoNCj4NCj4gVGhlcmUgYXJlIG5vIGlzc3VlcyB3aXRoIHJ1bm5pbmcg
U01DLCBTbW9rZSB0ZXN0cyBidXQgd2hpbGUgcnVubmluZyBMVFANCj4gdGVzdHMgaXQgaXMgdHJ5
aW5nIHRvIGluc3RhbGwgc29tZSBkZXBlbmRlbmN5IHBhY2thZ2VzIHRvIHRoZSByb290IGZpbGUN
Cj4gc3lzdGVtLiBDdXJyZW50bHkgaXQgc2hvd3MgaXQgaXMgYSBuZXR3b3JrIGlzc3VlIGJ1dCBl
dmVuIGlmIGl0IGdldHMNCj4gcmVzb2x2ZWQsIHRoZSBwYWNrYWdlcyBjYW5ub3QgYmUgaW5zdGFs
bGVkIGJlY2F1c2UgdGhlIHNlY3VyaXR5IGltYWdlIGhhcw0KPiByZWFkLW9ubHkgcm9vdCBmaWxl
IHN5c3RlbS4NCg0KU28geW91J2QgZWl0aGVyIGhhdmUgdG8gdXNlIGEgd3JpdGFibGUgZmlsZXN5
c3RlbSBvciBwcmUtaW5zdGFsbCBldmVyeXRoaW5nIGludG8gdGhlIG9yaWdpbmFsIGltYWdlLg0K
DQo+DQo+IEFub3RoZXIgaWRlYSB3aGljaCBuZWVkcyB0byBiZSBkaXNjdXNzZWQgaXMsIHNpbmNl
IEtlcm5lbCB0ZXN0cyBieSBuYW1lDQo+IG1lYW5zIGZvY3VzaW5nIG9uIHRlc3Rpbmcgb25seSB0
aGUgS2VybmVsLCB3ZSBjYW4gdHJ5IHRvIHVzZSBhIGRpZmZlcmVudA0KPiByb290IGZpbGUgc3lz
dGVtIHRvIHJ1biB0aGVzZSB0ZXN0cy4gQnV0IHRoaXMgaXMganVzdCBhbiBpZGVhLCB0aGlzIG5l
ZWRzDQo+IHRvIGludGVybmFsbHkgYmUgZGlzY3Vzc2VkIHdpdGhpbiBTV0cgYW5kIHdpdGggQ2Vy
dGlmaWNhdGlvbiBib2R5Lg0KDQpUaGVyZSdzIG5vIGhhcm0gaW4gdXNpbmcgYSBkaWZmZXJlbnQg
cm9vdGZzLCBvciBpbiBpbXByb3ZpbmcgdGhlIG9uZSBjdXJyZW50bHkgdXNlZCBmb3IgS2VybmVs
IHRlc3RpbmcuDQpJbmRlZWQgSSBiZWxpZXZlIEl3YW1hdHN1LXNhbiBjcmVhdGVkIHNlcGFyYXRl
IGltYWdlcyBmb3IgTFRQIHRlc3RpbmcgcHJldmlvdXNseSBhbnl3YXkuDQoNCj4NCj4gSSByZXF1
ZXN0IHlvdSB0byBwcm92aWRlIGFueSBzdWdnZXN0aW9ucyByZWdhcmRpbmcgdGhlIGF0dGFjaGVk
IExUUA0KPiBpc3N1ZXMuDQoNCllvdSdkIG5lZWQgYSB3b3JraW5nIGludGVybmV0IGNvbm5lY3Rp
b24gdG8gc29sdmUgdGhlIHNwZWNpZmljIGlzc3VlcyBpbiB0aGF0IGxvZy4NCg0KS2luZCByZWdh
cmRzLCBDaHJpcw0KDQo+DQo+IFRoYW5rcyBhbmQgcmVnYXJkcywNCj4gU2FpIEFzaHJpdGggKFQg
UyBJIFApDQo+DQo=

--_000_OS3PR01MB61038562D6A34A0313834A60C22F2OS3PR01MB6103jpnp_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dks_c_5601=
-1987">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello Chris,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hope you are doing well.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I have created a custom branch in isar-cip-core from which I created a x86 =
generic uefi rootfs tarball with LTP binary installed,
<a href=3D"https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/=
cip-core/sai-deploy-x86uefi-rootfs-ltp/x86-uefi/cip-core-image-cip-core-boo=
kworm-x86-uefi-test.tar.gz" id=3D"LPlnk423295" class=3D"OWAAutoLink">
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-core/sa=
i-deploy-x86uefi-rootfs-ltp/x86-uefi/cip-core-image-cip-core-bookworm-x86-u=
efi-test.tar.gz</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I ran LTP tests on M-COM on LAVA for <b>6.1.115-cip31.</b></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Please have a look at the list of jobs ran recently on M-COM <b><a href=3D"=
https://lava.ciplatform.org/scheduler/device_type/x86-siemens-mcom" id=3D"L=
PlnkOWAb7f9afcc-5d1a-19a3-695e-32880adad1ef" class=3D"OWAAutoLink">LAVA | S=
cheduler | Device Types | x86-siemens-mcom</a></b></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith (T S I P)</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Chris Paterson &lt;Ch=
ris.Paterson2@renesas.com&gt;<br>
<b>Sent:</b> Monday, November 25, 2024 9:17 PM<br>
<b>To:</b> ashrith sai(=A3=D4=A3=D3=A3=C9=A3=D0) &lt;Sai.Sathujoda@toshiba-=
tsip.com&gt;<br>
<b>Cc:</b> hayashi kazuhiro(=D7=F9 =FB=FA=CE=DB =A3=C4=A3=CD=A3=C5 =A1=DB=
=A3=C4=A3=C9=A3=C7=A1=E0=A3=CD=A3=D0=A3=D3=A1=DB=A3=CD=A3=D0=A3=B4) &lt;kaz=
uhiro3.hayashi@toshiba.co.jp&gt;; dinesh kumar(=A3=D4=A3=D3=A3=C9=A3=D0 TMI=
EC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;; cip-security@lists.c=
ip-project.org &lt;cip-security@lists.cip-project.org&gt;; iwamatsu nobuhir=
o(=E4=DB=E1=E6 =E3=E1=E5=C7 =A1=DB=A3=C4=A3=C9=A3=D4=A3=C3=A1=E0=A3=C4=A3=
=C9=A3=D4=A1=DB=A3=CF=A3=D3=A3=D4)
 &lt;nobuhiro1.iwamatsu@toshiba.co.jp&gt;; cip-dev@lists.cip-project.org &l=
t;cip-dev@lists.cip-project.org&gt;<br>
<b>Subject:</b> RE: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:Gulim}
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Aptos}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Gulim",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
span.x_EmailStyle20
	{font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:72.0pt 72.0pt 72.0pt 72.0pt}
-->
</style>
<div lang=3D"EN-GB" style=3D"word-wrap:break-word">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Hello Sai,</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Apologies for the slow response.<=
/span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Well done for getting the LTP tes=
ts running locally.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">If you send me the tarball or lin=
k me to it I can upload it to S3 for you.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Aptos&quot;,sans-serif; color:#7030A0">Kind regards, Chris</span></p>
</div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0cm 0cm 0c=
m 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0c=
m 0cm 0cm">
<p class=3D"x_MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;=
 font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"=
EN-US" style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-seri=
f"> Sai.Sathujoda@toshiba-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> 21 November 2024 13:38<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> kazuhiro3.hayashi@toshiba.co.jp; dinesh.kumar@toshiba-tsip.com; =
cip-security@lists.cip-project.org; nobuhiro1.iwamatsu@toshiba.co.jp; cip-d=
ev@lists.cip-project.org<br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Hello Chris,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Hope you are doing great.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">This is just an update regarding my previous query in t=
his mail thread.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">I was able to run LTP on security target in my machine =
after including
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/mas=
ter/kas/opt/test.yml?ref_type=3Dheads" data-auth=3D"NotApplicable">
kas/opt/test.yml =A1=A4 master =A1=A4 cip-project / cip-core / isar-cip-cor=
e =A1=A4 GitLab</a>&nbsp;while building the image as it&nbsp;comes all the =
dependencies required to run them.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">For LAVA, I will try to upload a rootfs tarball to cip-=
project's S3 storage with build:x86-uefi-base configuration along with
<b>extension: test</b>. I hope I can run LTP tests on M-COM x86 on LAVA wit=
h this method. I ran SMC tests on M-COM x86 with 6.1.112-cip30 kernel -&gt;
<a href=3D"https://lava.ciplatform.org/results/1222616/0_spectre-meltdown-c=
hecker-test" data-auth=3D"NotApplicable">
https://lava.ciplatform.org/results/1222616/0_spectre-meltdown-checker-test=
</a></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Thanks and regards.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Sai Ashrith</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt; on behalf of
<a href=3D"mailto:sai.sathujoda@toshiba-tsip.com">sai.sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:sai.sathujoda@toshiba-tsip.com">sai.sathujo=
da@toshiba-tsip.com</a>&gt;<br>
<b>Sent:</b> Friday, November 15, 2024 7:14 PM<br>
<b>To:</b> <a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2@r=
enesas.com</a> &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Pat=
erson2@renesas.com</a>&gt;<br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"KO" style=3D"font-size:11.=
0pt; color:black">=D7=F9</span><span lang=3D"KO" style=3D"font-size:11.0pt;=
 font-family:&quot;Calibri&quot;,sans-serif; color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt; color:black">=FB=FA=CE=
=DB</span><span lang=3D"KO" style=3D"font-size:11.0pt; font-family:&quot;Ca=
libri&quot;,sans-serif; color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt; color:black">=A3=C4=A3=
=CD=A3=C5</span><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&=
quot;,sans-serif; color:black"> =A1=DB</span><span lang=3D"KO" style=3D"fon=
t-size:11.0pt; color:black">=A3=C4=A3=C9=A3=C7</span><span style=3D"font-si=
ze:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">=A1=E0<=
/span><span lang=3D"KO" style=3D"font-size:11.0pt; color:black">=A3=CD=A3=
=D0=A3=D3</span><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&=
quot;,sans-serif; color:black">=A1=DB</span><span lang=3D"KO" style=3D"font=
-size:11.0pt; color:black">=A3=CD=A3=D0=A3=B4</span><span style=3D"font-siz=
e:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"KO" style=3D"font-s=
ize:11.0pt; color:black">=A3=D4=A3=D3=A3=C9=A3=D0</span><span style=3D"font=
-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> TMI=
EC
 ODG Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.k=
umar@toshiba-tsip.com</a>&gt;;
<a href=3D"mailto:cip-security@lists.cip-project.org">cip-security@lists.ci=
p-project.org</a> &lt;<a href=3D"mailto:cip-security@lists.cip-project.org"=
>cip-security@lists.cip-project.org</a>&gt;; iwamatsu nobuhiro(</span><span=
 lang=3D"KO" style=3D"font-size:11.0pt; color:black">=E4=DB=E1=E6</span><sp=
an lang=3D"KO" style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,s=
ans-serif; color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt; color:black">=E3=E1=E5=
=C7</span><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,=
sans-serif; color:black"> =A1=DB</span><span lang=3D"KO" style=3D"font-size=
:11.0pt; color:black">=A3=C4=A3=C9=A3=D4=A3=C3</span><span style=3D"font-si=
ze:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">=A1=E0<=
/span><span lang=3D"KO" style=3D"font-size:11.0pt; color:black">=A3=C4=A3=
=C9=A3=D4</span><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&=
quot;,sans-serif; color:black">=A1=DB</span><span lang=3D"KO" style=3D"font=
-size:11.0pt; color:black">=A3=CF=A3=D3=A3=D4</span><span style=3D"font-siz=
e:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">)
 &lt;<a href=3D"mailto:nobuhiro1.iwamatsu@toshiba.co.jp">nobuhiro1.iwamatsu=
@toshiba.co.jp</a>&gt;;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt;<br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</span>
</p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,san=
s-serif">&nbsp;</span></p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Hello Chris,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Hope you are doing well.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">After going through Lava job definitions where ltp test=
s are run on CIP reference hardware on CIP LAVA,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">I noticed that ltp tests are being mostly on:</span></p=
>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">renesas_r8a7743-iwg20d-q7</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">renesas_r8a774a1-hihope-rzg2m-ex</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">x86_cip_qemu</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Using rootfs tarballs such as:</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black"><a href=3D"https://s3-eu-central-1.amazonaws.com/downlo=
ad2.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qe=
muarm64-ltp.tar.bz2" data-auth=3D"NotApplicable">https://s3-eu-central-1.am=
azonaws.com/download2.cip-project.org/cip-testing/lava-healthchecks/rfs/cor=
e-image-minimal-qemuarm64-ltp.tar.bz2</a></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black"><a href=3D"https://s3-eu-central-1.amazonaws.com/downlo=
ad2.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qe=
mux86-64-ltp.ext4.xz" data-auth=3D"NotApplicable">https://s3-eu-central-1.a=
mazonaws.com/download2.cip-project.org/cip-testing/lava-healthchecks/rfs/co=
re-image-minimal-qemux86-64-ltp.ext4.xz</a></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">..along with respective dtb files.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">But currently m-com health checks are using
<a href=3D"https://s3-us-west-2.amazonaws.com/download.cip-project.org/cipt=
esting/cip-lava/rfs/rootfs-simatic-ipc227e.tar.gz" data-auth=3D"NotApplicab=
le">
https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/cip-=
lava/rfs/rootfs-simatic-ipc227e.tar.gz</a> rootfs.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">I tried to use &nbsp;SKIP_INSTALL: &quot;false&quot; in=
 the test definition because ltp test cases are not present in expected fol=
ders, ex: /opt/ltp and dependency packages as well expecting
 they will be installed in the image after boot. But the job failed. <u><a =
href=3D"https://lava.ciplatform.org/scheduler/job/1223149#L1339" data-auth=
=3D"NotApplicable">https://lava.ciplatform.org/scheduler/job/1223149#L1339<=
/a></u></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">I request you to help me in preparing a simatic-ipc227e=
 rootfs tarball with ltp tests and required packages and pushing cip-projec=
t s3 storage so that I can run ltp tests on m-com
 device. Please suggest if you know any alternate rootfs can be used to boo=
t on m-com device.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Thanks and regards,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Sai Ashrith</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:white"><a href=3D"https://s3-eu-central-1.amazonaws.com/downlo=
ad2.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qe=
muarm64-ltp.tar.bz2" data-auth=3D"NotApplicable">https://s3-eu-central-1.am=
azonaws.com/download2.cip-project.org/cip-testing/lava-healthchecks/rfs/cor=
e-image-minimal-qemuarm64-ltp.tar.bz2</a></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:white"><a href=3D"https://s3-eu-central-1.amazonaws.com/downlo=
ad2.cip-project.org/cip-testing/lava-healthchecks/rfs/core-image-minimal-qe=
mux86-64-ltp.ext4.xz" data-auth=3D"NotApplicable"><span style=3D"color:whit=
e">https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-test=
ing/lava-healthchecks/rfs/core-image-minimal-qemux86-64-ltp.ext4.xz</span><=
/a></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt; on behalf of Chris Paterson via lists.cip-project.o=
rg &lt;<a href=3D"mailto:chris.paterson2=3Drenesas.com@lists.cip-project.or=
g">chris.paterson2=3Drenesas.com@lists.cip-project.org</a>&gt;<br>
<b>Sent:</b> Tuesday, November 12, 2024 7:39 PM<br>
<b>To:</b> <a href=3D"mailto:cip-security@lists.cip-project.org">cip-securi=
ty@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-security@lists.cip-p=
roject.org">cip-security@lists.cip-project.org</a>&gt;; iwamatsu nobuhiro(<=
/span><span lang=3D"KO" style=3D"font-size:11.0pt; color:black">=E4=DB=E1=
=E6</span><span lang=3D"KO" style=3D"font-size:11.0pt; font-family:&quot;Ca=
libri&quot;,sans-serif; color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt; color:black">=E3=E1=E5=
=C7</span><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,=
sans-serif; color:black"> =A1=DB</span><span lang=3D"KO" style=3D"font-size=
:11.0pt; color:black">=A3=C4=A3=C9=A3=D4=A3=C3</span><span style=3D"font-si=
ze:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">=A1=E0<=
/span><span lang=3D"KO" style=3D"font-size:11.0pt; color:black">=A3=C4=A3=
=C9=A3=D4</span><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&=
quot;,sans-serif; color:black">=A1=DB</span><span lang=3D"KO" style=3D"font=
-size:11.0pt; color:black">=A3=CF=A3=D3=A3=D4</span><span style=3D"font-siz=
e:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">)
 &lt;<a href=3D"mailto:nobuhiro1.iwamatsu@toshiba.co.jp">nobuhiro1.iwamatsu=
@toshiba.co.jp</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip=
-dev@lists.cip-project.org</a>&gt;; hayashi kazuhiro(</span><span lang=3D"K=
O" style=3D"font-size:11.0pt; color:black">=D7=F9</span><span lang=3D"KO" s=
tyle=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color=
:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt; color:black">=FB=FA=CE=
=DB</span><span lang=3D"KO" style=3D"font-size:11.0pt; font-family:&quot;Ca=
libri&quot;,sans-serif; color:black">
</span><span lang=3D"KO" style=3D"font-size:11.0pt; color:black">=A3=C4=A3=
=CD=A3=C5</span><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&=
quot;,sans-serif; color:black"> =A1=DB</span><span lang=3D"KO" style=3D"fon=
t-size:11.0pt; color:black">=A3=C4=A3=C9=A3=C7</span><span style=3D"font-si=
ze:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">=A1=E0<=
/span><span lang=3D"KO" style=3D"font-size:11.0pt; color:black">=A3=CD=A3=
=D0=A3=D3</span><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&=
quot;,sans-serif; color:black">=A1=DB</span><span lang=3D"KO" style=3D"font=
-size:11.0pt; color:black">=A3=CD=A3=D0=A3=B4</span><span style=3D"font-siz=
e:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"KO" style=3D"font-s=
ize:11.0pt; color:black">=A3=D4=A3=D3=A3=C9=A3=D0</span><span style=3D"font=
-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> TMI=
EC
 ODG Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.k=
umar@toshiba-tsip.com</a>&gt;<br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</span>
</p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,san=
s-serif">&nbsp;</span></p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt">Hello Sai,<br>
<br>
&gt; From: <a href=3D"mailto:cip-security@lists.cip-project.org">cip-securi=
ty@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-security@lists.cip-%=
0b">cip-security@lists.cip-<br>
</a>&gt; project.org&gt; On Behalf Of sai ashrith sathujoda via lists.cip-p=
roject.org<br>
&gt; Sent: 12 November 2024 04:14<br>
&gt; <br>
&gt; Hello Chris,<br>
&gt; <br>
&gt; Hope you are doing well.<br>
&gt; <br>
&gt; Regarding IEC 62443-4-2 certification, the certification body has aske=
d<br>
&gt; for Kernel and IEC test results on M-COM device. Based on my current<b=
r>
&gt; knowldege, I believe that the test suites mentioned here<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-" =
data-auth=3D"NotApplicable">
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-</a><br>
&gt; /blob/master/submit_tests.sh?ref_type=3Dheads#L55 &lt;<a href=3D"https=
://gitlab.com/cip-%0b" data-auth=3D"NotApplicable">https://gitlab.com/cip-<=
br>
</a>&gt; project/cip-testing/linux-cip-ci/-<br>
&gt; /blob/master/submit_tests.sh?ref_type=3Dheads#L55&gt;</span><span styl=
e=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif">&nbsp;</=
span><span style=3D"font-size:11.0pt"> shall run for every<br>
&gt; updated kernel image on different CIP reference hardware in LAVA.<br>
&gt; <br>
&gt; Since availability of M-COM device on CIP LAVA Lab still needs some ti=
me,<br>
&gt; we are manually running each test suite i.e SMC, Smoke, LTP etc. from<=
br>
&gt; <a href=3D"https://github.com/kernelci/test-definitions" data-auth=3D"=
NotApplicable">
https://github.com/kernelci/test-definitions</a><br>
<br>
As Jan said - we now have one in CIP's LAVA.<br>
If you have issues using it please let me know.<br>
<br>
&gt; <br>
&gt; There are no issues with running SMC, Smoke tests but while running LT=
P<br>
&gt; tests it is trying to install some dependency packages to the root fil=
e<br>
&gt; system. Currently it shows it is a network issue but even if it gets<b=
r>
&gt; resolved, the packages cannot be installed because the security image =
has<br>
&gt; read-only root file system.<br>
<br>
So you'd either have to use a writable filesystem or pre-install everything=
 into the original image.<br>
<br>
&gt; <br>
&gt; Another idea which needs to be discussed is, since Kernel tests by nam=
e<br>
&gt; means focusing on testing only the Kernel, we can try to use a differe=
nt<br>
&gt; root file system to run these tests. But this is just an idea, this ne=
eds<br>
&gt; to internally be discussed within SWG and with Certification body.<br>
<br>
There's no harm in using a different rootfs, or in improving the one curren=
tly used for Kernel testing.<br>
Indeed I believe Iwamatsu-san created separate images for LTP testing previ=
ously anyway.<br>
<br>
&gt; <br>
&gt; I request you to provide any suggestions regarding the attached LTP<br=
>
&gt; issues.<br>
<br>
You'd need a working internet connection to solve the specific issues in th=
at log.<br>
<br>
Kind regards, Chris<br>
<br>
&gt; <br>
&gt; Thanks and regards,<br>
&gt; Sai Ashrith (T S I P)<br>
&gt; </span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB61038562D6A34A0313834A60C22F2OS3PR01MB6103jpnp_--


