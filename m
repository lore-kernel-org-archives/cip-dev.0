Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3084CA0EDC
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 13:59:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.23325.1755179961726149913
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Aug 2025 06:59:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 57EDxHXC1017743; Thu, 14 Aug 2025 22:59:18 +0900
X-Iguazu-Qid: 2rWhyCKR9orgftcw88
X-Iguazu-QSIG: v=2; s=0; t=1755179957; q=2rWhyCKR9orgftcw88; m=U2ACqKTwccGVKnMzdF+a9TY/2Nc/BjSUygrdhJd3ZLY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 57EDxF0B3533044
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 22:59:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLaAewnqu/SaxhXFIeRiBaq9lSwWQlB88AEU8CETxUpqfMZ9OkS53HZ/3hha/aCAZrpl+XlD4p7IpUG5y47SBLuaUvpu1DIEGTdkRS+LJ6Tk56RGaIEJED1ClGJk1OjenRi7wq4yii68Z+phsklhOi9EdvwVyaDDt770R6ea6M1Xu6lvwwaMA1HmdN8QZkcGfJceKV9Hh4ojRqbn4cWuOt/Cg3SwM/ErHWU9beq84Kz+3ySrMnBzS9noeyVJm3rsayNgtiaULWBQkCgkkxRxEPg77SUJe5iJ+FOgIvxo5cfjrespPEk4DOUqVYvAfXqCZaXlRxt1GaBRW1XYX/EqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7UidqpU8JQ90njTlYeGMDxvD2K7IsbUwvwqCI/4jDM=;
 b=tIB3L+3lJQScnVltBQL+hJDgtUApwR7lxV08uTmp4eNW23U4CF5+pSESGltGoJTcnZQrl84ibHFqImwBqR1LZ9lvb87SmBzK+rKw8AB9guYuU99lTYqKC3r4gyIMj29EUOcHxB2ffo2+5ToZhlWCUt4PWluyUO1szVAeYZGOfYp0+VtSVRZzAuaQWABeGsm0cbt80HqpTW55zYH2pLVZf1VaTuEQTxwwkJ25roZfdJfx0tKqE4rPM9EOeUwF324qcY18nLIkeY1xUB2js7YUO+iBe/XPTKARmX01d5cXVJghwNZ1Y/lNInw/M5uNFpRw75AFg/rULu6d1bg5jH2a8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <chris.paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <jan.kiszka@siemens.com>
Subject: Effective QEMU devices usage for testing in LAVA
Thread-Topic: Effective QEMU devices usage for testing in LAVA
Thread-Index: AdwNI0Zo7YnIbeRzQ4KMFrrfEXZpJA==
Date: Thu, 14 Aug 2025 13:59:12 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075A93846FA70A1AEB01145C735A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYRPR01MB13977:EE_
x-ms-office365-filtering-correlation-id: ff38ee07-4713-403b-0d7e-08dddb3abfa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|8096899003|13003099007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?N2dYcjd1SHFwUGNELzFVWUNtVElZWGlmbzhDdWhqRFp1V0JNbXlGbWNo?=
 =?iso-2022-jp?B?MnNRK0pSUEh5K0owZVp3SE1YSDRUY21ma205ckwrWWZBWUFHTWZyaDd2?=
 =?iso-2022-jp?B?WTZsS2swamVJbDE5UDJSRFMyLzVvNG04VTY2YWVVdGdqclNCK2lMd01l?=
 =?iso-2022-jp?B?MUZYWUh0ak9HeElZRU50QTk5UDUvdlVkdGMyUFNyZkwxN0drQXBmOGpJ?=
 =?iso-2022-jp?B?b1NLTWhYVHo1dlo2L0h3NEJIazBrKzFMamV5MHVHMkpWa3hMWGFtakdw?=
 =?iso-2022-jp?B?RkNkci9wVW1odWlIRnNkUWUvMGpsWk1RT0M0bTVHeEdPcjhvSzl2OWJp?=
 =?iso-2022-jp?B?S3BzYUh5VUtoTkVHMVFsNDZGKzhqUERBVnNPOFNkaHRic1hwT1NHYUtE?=
 =?iso-2022-jp?B?YVhtbjVDc2JoMjRuSHltd3RVM3Uramx4TEN2NHFrSWFpZlh0NXlaS3pD?=
 =?iso-2022-jp?B?MGw0OVJyS3EyeGlYQWo3dm1uZnN6UTR4blRsZkEyY2N6MnNaZHN3U3dH?=
 =?iso-2022-jp?B?bElveEVQM0Z2YWhWZEErQUprOUFWa3U2cGZuZ003LzJYaWZYZlgxaXVi?=
 =?iso-2022-jp?B?bmN5WlVJZEswVG1BdkVVSTNiUnVCdDFvS0NYanFoUHZ1MDNKeVNpNEhR?=
 =?iso-2022-jp?B?NVNMUThXRlpSVDJIT2lJZ0szaS9BSEZFblJNWkRZM0FsUmpnanV5WFJX?=
 =?iso-2022-jp?B?YXUzMCtCZGtKT2t6TU4yeGxVYmpDU3JQSVB4aDQ2WkNYTkhwcnJ4MmZs?=
 =?iso-2022-jp?B?ZHFTMVV3VENxd3M5cmFLOEY0S1hrcDBXOVBtR0tHeFpFeTBHVjN2YTRs?=
 =?iso-2022-jp?B?R0w1UEF1NHR0L3V3SHlWNmdTSFJ3dkcvQTZtZjFKNFYvT1RZTGdtZGFj?=
 =?iso-2022-jp?B?ZFdlaGVVamVwVk5mSWQzeUJCQy9rTUlpQzdXQ2J4S2NtV1F4cUZRMWV5?=
 =?iso-2022-jp?B?NmxzWkNFOCtWOE9KcW9GcDZUZjZXaU96eWJnM0RkK1NJVTA5ZFlhQVBJ?=
 =?iso-2022-jp?B?OUdHWndMUCt6cnBjaUQzMnVkYmZFUTc5ZjBMbmRRekRIcVd1aEZRUm01?=
 =?iso-2022-jp?B?N2FyZ1loTXBhcnN4RlFNSnZ2RnFHY3M0eE1CNzBkVUtFeGlVOTUvWEZ0?=
 =?iso-2022-jp?B?UFprdjJtZndreitvRCtwZVUrYm1WRWN3Y2l2TlF2azVnNGt4dDBwRjkz?=
 =?iso-2022-jp?B?NjlIcHBOMkFjY1FUUitIK1lNQTQwYUxycDVWeCtzWHIwR3BrSlVhWU1q?=
 =?iso-2022-jp?B?Mmh5MXJoc3k1dUYvT1JoN1pORldJU2tlL1o2eU4yZ2FPTDBJdjRuUmlj?=
 =?iso-2022-jp?B?L01zMlhxdWJnZFppb3NQOTF3T1d4QXZYaWFXdy9palNNSHYrYnlCTlpt?=
 =?iso-2022-jp?B?YWlZMFF1YWd5N1VVT3hFcHVlbURaUURLbHQwRUlOb2Q2VzYxVCs4M0I5?=
 =?iso-2022-jp?B?MlNSa1AxV241YXNZR0ZrdnBtakRDSXFuL0JiOVlpR0svTWp2WWZRMmVz?=
 =?iso-2022-jp?B?LzhtS3ZDam9YdmgrL1NCZ2FlSWo2c1g3SmxEZTllTXUwOTdBNFpQMTNE?=
 =?iso-2022-jp?B?d1JoMzNYWW9lZHpYYzRZcisvdEx1MFhMdlJqQlduUlRaT3BGcDBBZ1Fi?=
 =?iso-2022-jp?B?VXBNQ3VlZFhOQXRXU1BFODZGSWtzeHo0cDR1cWZCRVM4dDdFVGhrZFpM?=
 =?iso-2022-jp?B?VHFYbGFhdjdUNmJ5Um94Z1NLQ2lhZUNNQmdrMHNlSlc0TmsvUXhIL1g0?=
 =?iso-2022-jp?B?VWFkdnVjVjNnSkwrQnFMcnRlUHBNa3BwWEhzOEFjdFFEalVyc3FlcHZD?=
 =?iso-2022-jp?B?eHhBRlhxT04xQzdnREgxREJqTFptSG1DM3liR1ZBZHBXL3ZXYUFzR0tt?=
 =?iso-2022-jp?B?dXBEY0dONWQ4UHh2emhSSlp5THRFRXhISVpvN0J2bmFDamVUZyt6MGRP?=
 =?iso-2022-jp?B?VVgxYkUxVUxrY3NKRVEwNHhSWVpyTGdTVjM0cjJsZzk4V0cycExBODN6?=
 =?iso-2022-jp?B?alhRM25hMXphQ3E2RzZuV1hpT1BMTmRjMUNqbGJiTThDb3BlOFcwZkR2?=
 =?iso-2022-jp?B?MngxN0s2K0xXZTFJOFNuUnlhQkpCYkxDL3ltRVZKQ09BSFY4YkUzUEFF?=
 =?iso-2022-jp?B?Nzc=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(8096899003)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aC9QdHU4Z2ZYWUpDTWQ1bjNSdUEvTDU1dlQzQVRnV3dMejEweEdkN2Vx?=
 =?iso-2022-jp?B?RGtCVGFwUkJFTFMydC9HRHBnUVA3OHY0RitadWxtdUVnL2tHWU1lc3pt?=
 =?iso-2022-jp?B?K0lsT2lZOU5vTEFUa0Ntbk5xSVdrblZwTXdISEhjYnpJejBHcG9jTEZJ?=
 =?iso-2022-jp?B?OGlGQkVNVjMyVWs4Z1E3UkRRRE9ObWZQT2FYaUlnZlJxV1pvUytINTky?=
 =?iso-2022-jp?B?eEttY3NLcTVvT0Vza1lqdlZlTkJKZ1hrdERQek9BZU13QjlvYUYzSjVy?=
 =?iso-2022-jp?B?eDBJcnVkUmdibFppblNvcDNtNUxoQjRvK29ieEQ5MGJ0L0RQc2Q5bmtk?=
 =?iso-2022-jp?B?YlVjMERZK0lldVN1QXZtMXpPNlFTSW91dDVvYmw4YmdMd0FIME9JOEh5?=
 =?iso-2022-jp?B?clphTGFoeDU0ck5ycE5ZN1J0VDVVZ3BtaG53a3Zmb1Z4K1FZeVl5RUVa?=
 =?iso-2022-jp?B?dWZPdnMrcmx6cy9SVW8zWC9kZktUenh2MDA1WVBINXBqS1pIY3JTTWw4?=
 =?iso-2022-jp?B?Y3dVbmxiemc0dVhzaVFwbjlZbG5UdUxncXYybWdYcE4rVUZsOEdrTllS?=
 =?iso-2022-jp?B?Yll2TGV3Z1pEWFpYV3ByUjd0SDA5cTRjcytvaFRlUW53RDNZeXNURzhu?=
 =?iso-2022-jp?B?M0lqRlNNY2pNeGZlN1NDZjdJem9WcTVldU9XejV2YWp0UFFYWWozSUwr?=
 =?iso-2022-jp?B?RC9SS21oTDcwTWh2cFE5aXJqWmovUXNBMXRFZCtkK1JYY04yVUFrZEhk?=
 =?iso-2022-jp?B?RVp5djNmUFhkSDFidXdqdnI0YkdtRE4rb0FOM3ByaXJRWnFWNGZWZlRP?=
 =?iso-2022-jp?B?QkMyb0VUcDQ5Z1lHdkRIU0tDYzBuS1I3anEzSCswWlVZOG1zM0pMTDho?=
 =?iso-2022-jp?B?VzhLb05PakZGL0hMR0V5RGFubjhaZmZ5aVpROFg2aWNTU2FVRGM5RE5R?=
 =?iso-2022-jp?B?WXJ4UGhrWm1iU3puVm9vcm9qamdOSUVWM1JIbkovZlpmWW9FMDFzeVUx?=
 =?iso-2022-jp?B?YUwxdjVxWWM2TUZPNFM4blhVMnNsa0hGaW5oVlM2WDc2Ty82SHg3M0ti?=
 =?iso-2022-jp?B?V0x2TlBYc2FtWW8rNmJZRkZsLy8yNk02eGlxNURtaEt5N1huZHd0Z1JX?=
 =?iso-2022-jp?B?bzBZbkgrNldaVFpKZ093Y2lmMllFRWgzVWNtb1JIVDJrcDV0UnlCbjJz?=
 =?iso-2022-jp?B?TS9LQnVTZmRCemhTOFpxRmowK01jZTA4Y3BPaFBXMGpic0JYWEJtM21n?=
 =?iso-2022-jp?B?Nncrc2ozZEVOZkZ4cm9heHQ1eWdYTEZacWk2cjdMRlFQM3BDRnE0RFVj?=
 =?iso-2022-jp?B?Q3FUYmhzSUxONmhKbVo5Y2w2L1ZCWFZpWTYvczNFYnMxRXRRWnI3S1d1?=
 =?iso-2022-jp?B?bnZscmRtT2MxbWEzVkhnNE9KRXpWZ3BtbkN0ZmcyZmxHTTNicWQ4Tkcy?=
 =?iso-2022-jp?B?YVlsM3dUZ1dJY29BaE9ZejlHbTlPU09vOUdoc200WGFkTy8wZ1Nla2RW?=
 =?iso-2022-jp?B?SW1MamJ1N0tSenl0SXVqbG50bGNnNG5Qc2FuTjFNYi9DNXRMWWZpbjdJ?=
 =?iso-2022-jp?B?aHBjaHFNSnVwSm1HSkpqdWk2T0I5OE81Rmc4bnhacWd3UUxNYVJEdW43?=
 =?iso-2022-jp?B?akt0R1ZxNkR0VDIramtMTUJoOVRwVVhQRzE0dndvV1o1eG1qaENYcGUv?=
 =?iso-2022-jp?B?cWVDWDRRMTUzQVJPUmtzZk1maFVXcFZBMVc2Qmg1c3VkRlZFQ3R4WGJE?=
 =?iso-2022-jp?B?RnJEUkdRMkRYZXRkdGdCQ0JVS294RndEbHBJeHpRbkFyY2U5cGdUbXR1?=
 =?iso-2022-jp?B?NWxoeW5ySmh0KzM5Z1Q0ci8vSm9sVVJHdkJWV2dXV0NGQ2JtcWVRK3d6?=
 =?iso-2022-jp?B?d2lLZjlHOUs5Mk8xLzlHeUVLMHFHMzVGemtKcnc0TEdNQjh2ZVQ3M1JX?=
 =?iso-2022-jp?B?aTE3MUs1MUZxc1J2SHdsRU5QYTlEZEEzTGlYM3JSVUIyVVF3S3dkQ3Rq?=
 =?iso-2022-jp?B?Umdna2ZKUlRHYVpoTE5lNlNDc1FWR3F6NjNhWm1VWXFqSTNUbkMzTlZi?=
 =?iso-2022-jp?B?ZWhmMGlsejR3emFVR3Jnd1NNRUJmM2tGeDNXNFhLNzg3QTdxcTBsSG45?=
 =?iso-2022-jp?B?Ly9NNDJpSVR1aC8zSEFqQ0loU2U1dXlpYUJEdnlHQTVPZzlLby8yMHd6?=
 =?iso-2022-jp?B?UDNrZDJSbFNpTXZnWjNZSUJhY2J6ZzdvNmtCSjRBa3hzZ3R2OU1OalVZ?=
 =?iso-2022-jp?B?K2R1anRFMFJvYWMrN3lta1k0UTdrYkpqKy9la3NYV09WRDVzM3NuZ3Ri?=
 =?iso-2022-jp?B?UUhjQzJMVFZlV0QwOUlSK1RhMDI2NUZsR1pCaVFKTnc1SUZTNy9vL3NX?=
 =?iso-2022-jp?B?VHF1ZE09?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB11075A93846FA70A1AEB01145C735ATY3PR01MB11075jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff38ee07-4713-403b-0d7e-08dddb3abfa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 13:59:12.6015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqaUC9nvVumeNJiYXNJvcgakRaFPMgZ5VMTT0q02w3nipLrzrWzZ/UqqYNh/8DosG7qRI5K2zH8p7zwKRDNLgvER5JDaA4tv88YAYqf754N6N5qO7MklDenTlIgbtxVI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13977
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Aug 2025 13:59:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19748

--_000_TY3PR01MB11075A93846FA70A1AEB01145C735ATY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Hope this message finds you well.

As you may know, the CIP security images uses swtpm package for booting the=
 devices on QEMU.
we have added a separate tags to devices like =1B$B!H=1B(Bsw-update-testing=
, swtpm-jobs=1B$B!I=1B(B.
This makes the LAVA job specified with these tags will run only on the devi=
ces which are assigned with these tags.

I had a look on the list of QEMU devices on the current LAVA lab, I observe=
d there are many QEMU devices which are not assigned with these tags.
Example:
https://lava.ciplatform.org/scheduler/device/qemu-04
https://lava.ciplatform.org/scheduler/device/qemu-board
https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc
https://lava.ciplatform.org/scheduler/device/qemu-iwamatsu-01
https://lava.ciplatform.org/scheduler/device/qemu-patersonc-02
It restricts most of the CI jobs to use only the devices which are associat=
ed with these tags.
So if we update the same tags for other QEMU devices which provides more nu=
mber of devices to CI which will eventually speeds up CI pipeline execution=
.

At the moment, the pipeline is taking 183 minutes 54 seconds to complete it=
 [1]. So if there are no issues then we can consider to add the tags for ab=
ove devices as well.
This requires the update to each device dictionary[2] as well and also we m=
ight need to copy the scripts (swtpm_start.sh and swtpm_finish.sh) to each =
device.
I=1B$B!G=1B(Bm not quite sure about how to do update device dictionaries/ta=
gs.

So, please have a look at this once and let us know if any help required on=
 this.

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/19780=
31660/
[2] https://lava.ciplatform.org/scheduler/device/qemu-denx-01/devicedict

Thanks & Regards
Shivanand K

--_000_TY3PR01MB11075A93846FA70A1AEB01145C735ATY3PR01MB11075jp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Chris, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope this message finds you well. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As you may know, the CIP security images uses swtpm =
package for booting the devices on QEMU.
<o:p></o:p></p>
<p class=3D"MsoNormal">we have added a separate tags to devices like =1B$B!=
H=1B(B<b>sw-update-testing, swtpm-jobs</b>=1B$B!I=1B(B.
<o:p></o:p></p>
<p class=3D"MsoNormal">This makes the LAVA job specified with these tags wi=
ll run only on the devices which are assigned with these tags.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I had a look on the list of QEMU devices on the curr=
ent LAVA lab, I observed there are many QEMU devices which are not assigned=
 with these tags.<o:p></o:p></p>
<p class=3D"MsoNormal">Example: <o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://lava.ciplatform.org/scheduler/dev=
ice/qemu-04">https://lava.ciplatform.org/scheduler/device/qemu-04</a><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://lava.ciplatform.org/scheduler/dev=
ice/qemu-board">https://lava.ciplatform.org/scheduler/device/qemu-board</a>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://lava.ciplatform.org/scheduler/dev=
ice/qemu-cip-siemens-muc">https://lava.ciplatform.org/scheduler/device/qemu=
-cip-siemens-muc</a><o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://lava.ciplatform.org/scheduler/dev=
ice/qemu-iwamatsu-01">https://lava.ciplatform.org/scheduler/device/qemu-iwa=
matsu-01</a><o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://lava.ciplatform.org/scheduler/dev=
ice/qemu-patersonc-02">https://lava.ciplatform.org/scheduler/device/qemu-pa=
tersonc-02</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">It restricts most of the CI jobs to use only the dev=
ices which are associated with these tags.
<o:p></o:p></p>
<p class=3D"MsoNormal">So if we update the same tags for other QEMU devices=
 which provides more number of devices to CI which will eventually
<b>speeds up</b> CI pipeline execution.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">At the moment, the pipeline is taking <b>183 minutes=
 54 seconds</b> to complete it [1]. So if there are no issues then we can c=
onsider to add the tags for above devices as well.
<o:p></o:p></p>
<p class=3D"MsoNormal">This requires the update to each device dictionary[2=
] as well and also we might need to copy the scripts (swtpm_start.sh and sw=
tpm_finish.sh) to each device.
<o:p></o:p></p>
<p class=3D"MsoNormal">I=1B$B!G=1B(Bm not quite sure about how to do update=
 device dictionaries/tags.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So, please have a look at this once and let us know =
if any help required on this. &nbsp;&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[1] <a href=3D"https://gitlab.com/cip-project/cip-co=
re/isar-cip-core/-/pipelines/1978031660/">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/197803166=
0/</a>
<o:p></o:p></p>
<p class=3D"MsoNormal">[2] <a href=3D"https://lava.ciplatform.org/scheduler=
/device/qemu-denx-01/devicedict">
https://lava.ciplatform.org/scheduler/device/qemu-denx-01/devicedict</a> <o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K<o:p></o:p></p>
</div>
</body>
</html>

--_000_TY3PR01MB11075A93846FA70A1AEB01145C735ATY3PR01MB11075jp_--


