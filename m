Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD3C77B7E
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 05:53:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.43793.1685339621007974960
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 May 2023 22:53:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 34T5rJWT029877; Mon, 29 May 2023 14:53:19 +0900
X-Iguazu-Qid: 34trY2IxVzahOquT9p
X-Iguazu-QSIG: v=2; s=0; t=1685339598; q=34trY2IxVzahOquT9p; m=IGmebeXpPBlmMacxUAZbhPSZGM0xKVD/+UabViyQ1dk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 34T5rF9S036407
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 29 May 2023 14:53:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5qRNOZnrXQe56hhu8Pl2/N4GgTHR7X9/7I3LKSUVDLZuRHiEvF0v3LTdoVAz3/xB9OLquemRR0TfbfwbdfJdnW/hf0MQrr7sIxQWSkucLh7w8QcmvaQytXNFFMzuV5fhzevTieL5SQTWoIwOu0G6ffQqq2oFEoThdSNbJT0UiLmawCBAP5Dch1YMGW0mnzSOb2JLXKQ0PpwJJgsCV5WNgFJmzXML2ZMd52eTfYR04EEU+n/Zt2f6zlL6Fr2ewaUgRD07x7fdhVJ4m8SsAQwuNVq/+oofI1aiLDXzpzu7vLGfUIRGpHN/uOGBMwlCTX2MNiArMXlSY/KYfPyLUswig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDsig2aLs7cYaxNXYOGOjSuu6o3DXm/llPParolSfmM=;
 b=cNXBJWuCQnaew/a9fg42KR4RQyhY02xVInrZG3dn+fgXq46wYWuxoS3HfXS27rND4sl8eURk1AQ88BlGKv9yinHfHP2XK7IqeRkiegbVMEOpVzNMID7P44iYrTGwX2C3YadACQatxlX9b9LrpHZbyQyn+GLFco/i+vV/BisfEJloHkAHV9iqi0tSAKWRtr9nmd+V21Pz8cd/ESpsvMelAaXxZyB3ygXpGx7C05HILrSt//SJ9Vc8zsd1H0tdMrNADLYtakhe9oHKpA9fnL5KGUjysrxgq8Mg/tcnR/AqwuTpOulGCmsrlehbDy6eL7KAI0UCSkAbG/ZBA/CwQRBBYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v5.10.180-cip34
Thread-Topic: [ANNOUNCE] Release v5.10.180-cip34
Thread-Index: AdmR8aDoZVUqTp/+T6Kb/FCC3Sypww==
Date: Mon, 29 May 2023 05:53:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420D13445A8AD6D569C6B0B924A9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB10358:EE_
x-ms-office365-filtering-correlation-id: cf7731e8-1b61-45fb-dc2b-08db6008fc0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TVIpDI673Y5z05Qkkz/qBT0Ims/pi0bFdlsgb4liQzTfQ3uJojCwTw2HsgExyIX4sTI5ZGA8vp+d8eULyKm94dQ+YedXqi0ha1oB5kgyaDv/I6HGGUmjcAhvrpjmsKBVj1bJqVZhrLeV/42hfk+QcXqGMBaTcCyT2pvOpkt4oC686GRKZ3gyFugQgbbFhgzAFOp0oi982lO49uvxMCtCsDl+iUSvRyg07B67HmRYmcwR83k3oqb+PbVingKdcE9Ts3wRXpkIBQ/XMD5Tl2/eol+FyNnDIcK11V3IEAZw3+XRgrpF1Tb0Js7dTSs2wSxrfCHkfFHE4XSa9G/N/cYDjecWntSZFWWCgf5RFWeSWs8n6WaHlpnhUWKczKw2wXTpjIZR+/eTAQxX3gAUkxNt7q0qSwhWUh6VOrEuDREbE1Y8uFcRpI3FzvNtc7e/tDQLQl5CcgjVC8unvWVUDa5+QHhp+ZNPvpdfv0K5oN6BFA+i/pauYouLbEBBZuNi/tFOmNB4RTq6tJRwppCHCIl8IK1UCgwIOv7OdTj2NHOOSKjbRZMLc+0K57lydSJGxF3KrhCNAdFbbJnikaAr0T09xbkCp7+Ib1lsq5QN03msf9ITSig5t6cLYMWtrM4HS0kV
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199021)(38100700002)(41300700001)(966005)(7696005)(83380400001)(186003)(9686003)(6506007)(478600001)(71200400001)(54906003)(6916009)(64756008)(66446008)(66946007)(76116006)(66556008)(66476007)(122000001)(4326008)(55016003)(316002)(52536014)(5660300002)(8676002)(8936002)(38070700005)(86362001)(33656002)(2906002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YmpQN1IxS00ycmUwM3VrVWtHSVRYQnJ4OTA3djhuSGIwcGFjc3pZaDAw?=
 =?iso-2022-jp?B?Q21QQ0tHVC8wOTJXZkdUUXNXMzA4Qi92M1dYcHhhdi9taW1NYXhjbU5s?=
 =?iso-2022-jp?B?Yy9MSmloK29tWVJlZysyZEYxOWZab2tIWGg0RzVlR1JJR3F0UXJ3WnBu?=
 =?iso-2022-jp?B?RmVPWXRUeFI2WXVjR3ZSSExsenJ0QkFNVVNLQ2tHYU5pYVgxeFd4OW9H?=
 =?iso-2022-jp?B?b081dVBpYmVUS05hV3ltTnlpNlhIVmxhTmZXY0dQSC9rczRQcDJlUXFN?=
 =?iso-2022-jp?B?c3dNRkQvYzZZN1lOcXV2a2hVRTJmSHNva0F0bFdONlNCR2s5RGw0bTVT?=
 =?iso-2022-jp?B?ZFFiQ0Q4MjlqTTc4UXhRNEtrODRZdkRTZnd4YzRWcElPNlhEWXpYdXcy?=
 =?iso-2022-jp?B?MytIYVppY3A4YjhsS1VhSXpIUnYxK28xQ2cvU0xvVXVjT283UlloUmIx?=
 =?iso-2022-jp?B?SEM1SGlzLzM4VHNtTDcxYU9NOUNUSCttMTVUTmpTdENqT2I2Umw1eTF1?=
 =?iso-2022-jp?B?bGNZVm05alhnR2NTODh6ZkxaSXlSdGpINnVLSWRxSkJvYThDQ3gweXRa?=
 =?iso-2022-jp?B?YUROYkplVmxmN3M3bTBXRnlqYzc4SXFlZDVST0hZY3ZTZ1VaajdEbUZv?=
 =?iso-2022-jp?B?YnRISk5KSWltUmsycVprWmdYRjRicGdLRXBRZWFoY0VEeXpPdTdkT2pl?=
 =?iso-2022-jp?B?RkQ5N2FFVWhUSC9kK2FWL202NHNjUlpUaU1lM00wUVRtSG15Q2NpZ0tK?=
 =?iso-2022-jp?B?YW5LRXlQYThKaGplQ2JnZ2J2dmV3TmIwODZ5UXpPeGVNbllzZE83TGlE?=
 =?iso-2022-jp?B?eTZoekxUU1NJN25QSXVaUjdocVZUVE1DdnNMbXMwdXh4YzBkcVNWK3Fm?=
 =?iso-2022-jp?B?V1VkTkwyUWU1MFZzMEZqWDZ1RDNtSTVWT0FBZE9pRCtidXhLVTdCV1lw?=
 =?iso-2022-jp?B?K0M3d0ttVlFBMTZhdEM1ZnhmeXNCV0xiK205elpVZWZrZ1BURlViUkhp?=
 =?iso-2022-jp?B?ZjZNUmI5VWZmckZsVSs3b0tPS0dzODFQa1kzRCtQU0UrNTN3Z012bG9m?=
 =?iso-2022-jp?B?TDBUeVMycXVnanlMamlIdUlLUElXdzlJc1B3TEhIaEhLTE1xaHpOSDV5?=
 =?iso-2022-jp?B?WHljczRaSTkwVVdHT043d0ZRU3FUeFVRdlFLdGErNTlPcTZsYnp2MHhH?=
 =?iso-2022-jp?B?R3JIZEhnQi9Demg0cXFtYmdpTHIzakNzUW15bS85aC9yOVdoM0s4dmZZ?=
 =?iso-2022-jp?B?K3NEUVVYWlhESEZLN294SlZnZmtZNFZMK3lwbkFpbm0xV1REZWNHNUw1?=
 =?iso-2022-jp?B?d3dYdUhDaWo1ZkNPWUJhQUl0TUFlN201ckRhK3BVTGFGTk9ta1NQRVdy?=
 =?iso-2022-jp?B?Tnd6eXdnaUs2a3k4aXk5TlRwKzkvYjV2N2hNSXI2QWRPclgyaVRPWFR4?=
 =?iso-2022-jp?B?QW1xVDcySEIzTlhmL25SMjc0SjQzZWFoOFp2SzNUWHFQRFM4SDFsK3Bv?=
 =?iso-2022-jp?B?VlAwT3kvTGJXNk92VGZUb2NDaUZ3bXhwV09LemYySXhlakZaUlVBcUY3?=
 =?iso-2022-jp?B?MjN1Qm5uQzhiTG1OaGdMTzRWNEV0TnpVWXN4R3p5ZVRrdlJhOTZqcWxE?=
 =?iso-2022-jp?B?clRBK0xpejh6dHFZZXExLzR1UHdqOVdXRTBVS1UwSkpscFc4VWEzZmpw?=
 =?iso-2022-jp?B?VHVxTFRXUnN5UFRiUjBIdFYyV243Q0xhTzJuUU53QStob1hnYjRJZkYv?=
 =?iso-2022-jp?B?L0pFOGN5b1FKb0hxR29nWEpkaWsrVU1sVnRzWEpaa0RCbzF5aDlrSFNJ?=
 =?iso-2022-jp?B?RC92c21yN1NxazVBMld4SEhXYktRTXRKY3JGWVRQZ2RUYUtNMlJlMkFs?=
 =?iso-2022-jp?B?VngzM2hSS2dpaEY0d0NHeUJ5Vk0vaFA5SG9vT2Q0TzRzZ3dERmpqazgv?=
 =?iso-2022-jp?B?REVSOFQ2TXcxbklWV0ExMTZTcnhyc05jc1RLRHhIM1dsOHFSOXBjOThK?=
 =?iso-2022-jp?B?TStRdE45c2ZBNk9GN3hoQlVsbUdBNGQ0eUFlNlp1aWtGYXZTY2JJVTN2?=
 =?iso-2022-jp?B?QUtFdFFYNjFTUVBuNGhvSnFhR2s0MWtSUEZvMkRFbzdyRmV2VzlkbDBy?=
 =?iso-2022-jp?B?ajlIZzZBa29uNUVqOC85THl4UWkxTGtjUko1ek1WOEFHOGVpL2IxNW5p?=
 =?iso-2022-jp?B?ZlB0N1M2ZTlWS3YwZDZyd21mZjFNNVB4S1pTK09GV0VWTTlqS3ZSY0xS?=
 =?iso-2022-jp?B?R3U1a2VlRVVDSHVZdDlsVlNHMkJhSkpaR0hlNDAzWnIybFFqSXRJRVRU?=
 =?iso-2022-jp?B?L2YvOHYrM1RpdFRtMnRiL1V3NDdLU3VHOUlwRzJNR2t6V1JtaEk5ZXBG?=
 =?iso-2022-jp?B?MDFIQzNESkp2T21SK3RaVTRlMzI3cG1pVlJpOWc4N0pSbWt3MDN4RGRJ?=
 =?iso-2022-jp?B?Uk9sYjhBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?iso-2022-jp?B?SklocS9yM3VpR3hDMEZoWmFhdFFWNlJkTWlUUEZJanlwMWFZSmhKVVBs?=
 =?iso-2022-jp?B?QWJGWUpBeXJOQlllQWNVaTdGSXVjWnl6NWIrUytTbm9NQkNXdUc3RXNQ?=
 =?iso-2022-jp?B?VkJTWjlCblluN1NBNlB5Q2hQaGhnbWRVMS90dWFQTW5uNFI1dnN3cjhK?=
 =?iso-2022-jp?B?NGdncXFKSXVKZ1ZodEowTEl4QkZrZWxlSVprU21Ub29HblNMY29OLzlr?=
 =?iso-2022-jp?B?ZGY5cS9DSkI3YTR4QnkrM0ZoNmQxbzJPWHRINzFnVWlWT1hmMXJCeWVV?=
 =?iso-2022-jp?B?Qzk5aHdmUkxBSENRQ2NpZUdlVDdTN3VEOXkySUkwUHhqb0cwSG12ZEdH?=
 =?iso-2022-jp?B?bnJkTlNQUWxTZFNLanQzOFBGUkZmL2xZQmlrWm5nUXk5bENkV2tCL2pJ?=
 =?iso-2022-jp?B?b3gwV3hoSnJ3SzVQK3FWVnJzWXZpSU85NjNVVm90VFVWTmlwTEZBTXRu?=
 =?iso-2022-jp?B?STJXSjFOUXNxaGFnWDU5RWtocVRUMllkNFhBRG1MSmdoNDhFTTBnQXhZ?=
 =?iso-2022-jp?B?c2l1RWNiMVc3SVBCeThSbU1RVnJoWVlneUFDZWU0QzlUdzFORWZhMWJL?=
 =?iso-2022-jp?B?RU9TTDhvZm1RR2ZCT0gyc21Zck9QelJ4SjZub3QxOHBLTUFhbWtlVG85?=
 =?iso-2022-jp?B?YzFPaGxlSGVGSEMwMElwUEM4RFRzaFk3TFJIOHJTRVlEb2xMclRkTytx?=
 =?iso-2022-jp?B?QzhvZFloVnlTeXZDUHdjeUZRMXZEY0I3Mm1IN2g0ODdjV2ZHM0FGb3ZZ?=
 =?iso-2022-jp?B?MmdnU0VNMlhTR2VxUVVvTnRHaklVbWt0Tk90ak9oMmJBYWFuQmVNY0pD?=
 =?iso-2022-jp?B?SnIyNnl1L2lMQnRmUXJHL216YkpvMVZhdE5XMTlsbzJhc0RqckdHT3Ey?=
 =?iso-2022-jp?B?WnB3SW1zMkx6WGNONkxjLzNVNDI5V04xUE1BYm5Eeld0Z3BmNVRaN3ZO?=
 =?iso-2022-jp?B?Q3ZrYzRicVhRbDJZcSt3czVMeDJmWk9vYmFUaFFXN3ArUnRqTjdWQ2or?=
 =?iso-2022-jp?B?bm96d2JGMEZ6djJDRHhNNit5TzcwZFAwbVI0VzQ5Z0w2eks4cFpST2ZC?=
 =?iso-2022-jp?B?UGFHSWpUTWlZRDg5NUpJOTRCcktlTiswZWExL21jWlprNWxwc1ZIbjVK?=
 =?iso-2022-jp?B?WlYvRTcxV21qMXQ4V1U1bkovWDFaRngweExGSUc4YVFSU3VoRzUrKzJy?=
 =?iso-2022-jp?B?aStyREVxTlVTT1BBZEw0c0xhcTBBaDY3WUFjQjU1ZGQwbWtMVXVueVlM?=
 =?iso-2022-jp?B?VXZjT3V6Wi9ibEx2WmNhUlR1OGxMVUlxdkRZeHFpakFVaUR5dTFkL1Nz?=
 =?iso-2022-jp?B?Z2d4dnU1RHJnOGtiVXhFYXh5eDhQaEdTS1dBNGc1NElFTjRwMVFGZlFT?=
 =?iso-2022-jp?B?NFBFRkJ0TURKUGhBMy9iZz09?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7731e8-1b61-45fb-dc2b-08db6008fc0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 05:53:10.7595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2/AAx/UZSgBmkmop0bdkp1X+zmBQQM/HqykD9JdqEEMCG0sP0gJQ+thgiY6dt9sznXTrcVrgK2Ctmxkk/ZCz5mKcwC4JsQu3o5M8DIXbwgSkwZw3UvgqZM7TcD3xVJM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10358
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 05:53:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11681

Hi all,

CIP kernel team has released Linux kernel v5.10.180-cip34.
There is no base kernel update with LTS. Many updates for Renesas SoCs and =
boards has
been added to latest CIP kernel.=20
You can get this release via the git tree at:

  v5.10.180-cip34:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      aa80091745d6b40c944d419c12ba8cb65b1a57a5
    Fixed CVEs:
     None
    added commits:
      CIP: Bump version suffix to -cip34 after merge from cip tree
      arm64: defconfig: Enable additional support for Renesas platforms
      arm64: dts: renesas: rzv2m evk: Enable i2c
      arm64: dts: renesas: r9a09g011: Fix I2C SoC specific strings
      arm64: dts: renesas: r9a09g011: Add i2c nodes
      i2c: Add Renesas RZ/V2M controller
      dt-bindings: i2c: renesas,rzv2m: Change maintainer to Fabrizio Castro
      dt-bindings: i2c: renesas,rzv2m: Fix SoC specific string
      dt-bindings: i2c: Document RZ/V2M I2C controller
      clk: renesas: r9a09g011: Add IIC clock and reset entries
      driver core: add a helper to setup both the of_node and fwnode of a d=
evice
      arm64: dts: renesas: rzv2mevk2: Enable watchdog
      arm64: dts: renesas: r9a09g011: Add watchdog node
      watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
      watchdog: rzg2l_wdt: Add rzv2m support
      dt-bindings: watchdog: renesas,wdt: Add r9a09g011 (RZ/V2M) support
      clk: renesas: r9a09g011: Add WDT clock and reset entries
      arm64: dts: renesas: r9a09g011: Add system controller node
      arm64: dts: renesas: r9a09g011: Add L2 Cache node
      arm64: dts: renesas: r9a09g011: Reword ethernet status
      arm64: dts: renesas: r9a09g011: Fix unit address format error
      clk: renesas: r9a09g011: Add TIM clock and reset entries

Best regards,
   Nobuhiro


