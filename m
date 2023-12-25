Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F4EC3DA6E
	for <webhook@archiver.kernel.org>; Mon, 25 Dec 2023 06:08:53 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.56398.1703484528728201367
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Dec 2023 22:08:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 3BP68SnV538134; Mon, 25 Dec 2023 15:08:28 +0900
X-Iguazu-Qid: 2yAaiCPu9BOOOoAlMi
X-Iguazu-QSIG: v=2; s=0; t=1703484507; q=2yAaiCPu9BOOOoAlMi; m=lFd9uqpXf+lRIPvmEHWT10RssSP0vi1ZO0v5d8CatvU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 3BP68Ol62008790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 25 Dec 2023 15:08:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCLfiDjvvUrjzD/Avr58lF/fBFIbhHti4rBX3JPlRTVTDYC3wRokpPkyi1j1YWAkP/h3bhRdh9Gja9sXqKb+VkNBf7NrZjsNbn0qdiuv5ffo1nTv3u3Xv1qdLz1d2lPCYvGjhVPutDZKq+yUy41a7xuDmoy+egGhGOPErY+XkfwlbL3iHtSiLNqUQsPDnmQhhnNUEqO+rcpmjsAwXfwHLp3u0T8CdXIcxYp38ldrXVCnFx0JRYIZgygVYh2jSgtHWvdDtYHD4GiOtGVrEWaqiXn0zeODvPrj3KFWgp6s9+/fHCQZAjET0CPAK6Ih6Dy/AAKmQWBA4EG+Suqd+Ci7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxOcVAJgnCsfIug5Jw1L4nLnczV4SYvuXeOFsfevDCE=;
 b=D8f9WzOalOYDTl8CWL2RIYQyE+lVQzOFjV7vW6S8pYg6mEhLEfLZla3mej3n2XF7sL72mTWKAtwlHw73OND7myttO0o7CpzBmH5AwS3r4TNEfKk0uSnPk5iN1PPtbkfyYS1PKxVYOp98ta6gJ9O294gPBTIUwUe927CUklH7dePnTamJ3LKpKLaqiXcN72I/J8I5CvDGFlVYGt0t/VP15XRpzXNrTMPMXHrk3JVd6gJdbsEqnluhG+oSo+38scHC+dE32Hg0jfVxo0G80ivb9l8xI61LvF3dM+kWknrVCy0RTL2p2iYb5niRpI0Qin3D/iQ6b6w3qXuAXGhMulzy+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v5.10.205-cip42 and v6.1.67-cip12
Thread-Topic: [ANNOUNCE] Release v5.10.205-cip42 and v6.1.67-cip12
Thread-Index: Ado2zbDnlkS4H5FTS6qAkmMKGmF1ZQ==
Date: Mon, 25 Dec 2023 06:08:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB1124522792658D6523F2C04C39299A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TY3PR01MB11625:EE_
x-ms-office365-filtering-correlation-id: da53a6f6-1686-4084-108d-08dc050fe428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Lffyhi8V9fs9nNO1SGgzwjr3ymkZcPQ63VyG82ZAPPEuCdgQqsx+k6YKj5fnX/gLXh+akJdWbamM/ekuCjbfhjau1nr/IZWUv4NgNZFGOuw+oqCSMGVj6Ub9TvsjT3/kAAh5zHxk481MCT1mQ1wvaxH8GJeNtk0Ci1dQfX8V7jc1zrGdbCqF3nFgsM7HbtJ2axQ6R0yS41plqdWl/krB+KvynOARaIAvAKChwCt+PWpsIol7qj4Be1rfjOxzn9rrZHyNXyd8qGYDxsgRs1jednAkP9mZNhgLqPZYd3IIxKmYEKPovR8pulIN+woQYcXXGTdrYgvuGweB5XSfVAUFRkuknWnQ4ia9GZVjP3wSSKODNHYqItpE5c3h4Rb8BPx0WqlEAb9jMYhW8CcbJzjs74Se3IyQVZyIp6FC3HrKCMdmJ64B+YLvSNlWLA8GAial/bFyAcBPaj3MkD60BEYhYD/6VDSxqjEzUtAZPEbTJodPFb211N/X4BW/NNpqH6LeMNlW0CnoslTqk7G91Y3IxmBUtgMDDQkJgcf5oQCZELTL2InFT75QB+kbsAnajV8EkqoHpmo+KDD8qJeqXEeJB2qXOs2E75d18JiQ4RFncGbi009WeE8y+EZDAx4Hz8AHqyNa732i/rCrTC81ol+JYw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(966005)(478600001)(52536014)(76116006)(4326008)(55016003)(71200400001)(38100700002)(122000001)(26005)(7696005)(8936002)(86362001)(8676002)(54906003)(66446008)(66556008)(66946007)(66476007)(64756008)(6506007)(83380400001)(9686003)(6916009)(316002)(2906002)(41300700001)(33656002)(5660300002)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?N0tqQTU1UzhxQnM5V3Rjc0U4aUl1cVBmYmhqK0lNTEp5MUFhdXlVUHhC?=
 =?iso-2022-jp?B?elNRMUVsUngyZC9lTTYrYkJCRlhBcTdHelZjSUhJdzlFQzFKejEwa1pY?=
 =?iso-2022-jp?B?N3hCbHdBS2UwclcxZzJTdnFmeGFYa1dZUjBFOUF0MGo4WWJGQmthVjNm?=
 =?iso-2022-jp?B?TnhGYTlSS2lvcVFtT3lTV3R4dEpreGVPUkZ6a1hGZ2JUYy9pajdJS2cw?=
 =?iso-2022-jp?B?cG4zakVBUkdxMk8wT01GOU10OWYvZGFQb1JaNHRDRUszbkdmZGNpdHpX?=
 =?iso-2022-jp?B?b2ZpVlVOS045RWNsVGZrWjVZRjBoeXYwSVRJU0Y0dm9GcVhyZzVzQTMx?=
 =?iso-2022-jp?B?TGFVVkJZcVVCVUh5dGdZaFJxSWFCcjdZMmxLc2ZSelgzUkg0MVFjZFFv?=
 =?iso-2022-jp?B?a3NVS0VmaXg3cHlQYThEUTdVMHZHVEpyKy9DTGtIRnArbFBYOWlVVXVS?=
 =?iso-2022-jp?B?bElQSEsyNHBDZS9qeE1NMTRDWDd2K1EybkZHcXdkNDVtUmY5VHBzK1Uz?=
 =?iso-2022-jp?B?WE42OHNJLzRZbHdsWVhSNDc1Y0svbFYxUzkyR2JuVHV6SnVMV0JJdUE1?=
 =?iso-2022-jp?B?b3l4YjkwN21rV2ZkYkRJUkkyMHRzMFpXaUxzTVpaVGpJV2h3YjdrVjla?=
 =?iso-2022-jp?B?ZW1tcGVmWkJqUVpnak1LckVwbkEzNGk0V2YwcVR3SE9MNW5BOGhucTRm?=
 =?iso-2022-jp?B?RGhWK1lUWGdTMzZiZ2s5SENRN3lJQThhbnBhdUIxeWtGUTNrVlRrZ2k3?=
 =?iso-2022-jp?B?YmF4SHU4QThES1plZnBCVE9RckFRbWppcURrMlNDNkJySVBFdk8wTDNS?=
 =?iso-2022-jp?B?bGx1K0dTUkliVVNQY1ZvTW5JYUNoU2lNbWNBS0ZSb2hDcjlHZVF2SmVk?=
 =?iso-2022-jp?B?Nkx1bUNsQytyQW5HSHBTUGxvc0hzNGNjcUYwSVpvM205bmE3cHROS1do?=
 =?iso-2022-jp?B?cEVVbndRVGRDc3Y1VGpwM2Y3L2JrYkV5RDRWeGFRcTFpSzRsNTluWlQw?=
 =?iso-2022-jp?B?MERiY2VYQmFPM2xBekErSmtLK1hrQzRUcjZRdVE1eDFvb2ZXNjZVSS8v?=
 =?iso-2022-jp?B?bnREcXdGNlFOczJDM1B0OUxQM3I2aHc1YTcyL1ZDRjZ5UXZOUGJiU2tu?=
 =?iso-2022-jp?B?M2FzQnB0dDdRYWVTVHcxRXkyWHJZZStWYmZqZzQxNGw4VFo5R3JGVFk1?=
 =?iso-2022-jp?B?R3FteUJaaEMycC84aUYzc2dndnNEeWxZUDd6Zi9tNHNqNXBCN2kzWGoz?=
 =?iso-2022-jp?B?MGtrV1VXZ3FYWSs1ZStmalBCcnFJUFJNWFJjQ094UTJSRHZHV1RSUUhi?=
 =?iso-2022-jp?B?eUVVNnhvQ3NIVnJWNFVZYmVRblZIVGZCSCtEaDRJVEZrUDJOMlVrd1Ra?=
 =?iso-2022-jp?B?MlNpTHFIWEl1UnZGK1B4MjdiTFluYkw0SzZ5TFRacUlYR1RrM2dWRzZl?=
 =?iso-2022-jp?B?eHBraVZLa1d3WU1PVlh3RDRKNTI5VEVPZGNvam02b0hPK1JsMGZEalR4?=
 =?iso-2022-jp?B?NlVHc29oYU9jbEluMmNYUGVoczV6dmd2UnJVUStaWUdLNjJPR21vU2ov?=
 =?iso-2022-jp?B?bmlpSXc3SjB1UGphdG1ndXBVUG5wUGszc2lLVTZJS1pMeEhyTEJHWWFO?=
 =?iso-2022-jp?B?UWZvUWV2Mk14UjVTd3Ixbjh4YmFub2V4ZGp3RDFxSENLYnd6aEdpK2wx?=
 =?iso-2022-jp?B?akVzSVFBaUx1VnZ2aUwwSWZqeWRYbVNSaHkyTW1RaFA0cklOOUkvMlhk?=
 =?iso-2022-jp?B?OUZObjlucFNySVJWY1YrZTQ0L2JCcUFqVzFkaHZJOVRxTzRGcDZ6Znps?=
 =?iso-2022-jp?B?R2h6NXIzek53TjdYUGFKRlFCRHU3MHF4d2luZnR4SWpKWW5kc2xJR2J1?=
 =?iso-2022-jp?B?TXZMZHcxZU1DZFN1T2crWW9pc1ZUcTFkcnYyQU8yaHczTVdFOFI4djA5?=
 =?iso-2022-jp?B?R2lzR0tuUHEyUmFxcy8xeGdqeTgxTk45SkhCZzEvU0FZYVk3S2t4TGhv?=
 =?iso-2022-jp?B?djcxcGJZRDNXMFR5M1YvTU1tNHBlVXEvQm0vUUM2RmtSeTByNUxNRERr?=
 =?iso-2022-jp?B?MWtGQXBRL2l5Skp5UkFiakRjeXR2NzU5T0E5SEZxZG5uVDRTdVVyODUv?=
 =?iso-2022-jp?B?Mk5lTG8vdFJmaHRJYkloM0xrY3liWkZoTmlSUWF0SXFwbUpsV1lyRVMz?=
 =?iso-2022-jp?B?MzBxbkpQbkpQNk1CWU5lRlB4VnRwTnFsZU82Ymh3OWNFOUhOZzhidGZZ?=
 =?iso-2022-jp?B?dGhNYm5VcWZ1aXJkQWlwY1pNWmhqVzVNcTJnNVhuL0MwdnpZUUVYdHFz?=
 =?iso-2022-jp?B?OUFrNDRNb0QrY3dCSkw5UERUU01hT0dIdUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da53a6f6-1686-4084-108d-08dc050fe428
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2023 06:08:18.9977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOYaflMRP3liu0+1O0qhqjxnfUtDIen96QC3TuBltVBes/DEuXf3SZ1i2QpnKxndOaL84Tu9uJtOigcXIxtyduHD0cO4VixOFuTKQb5NUBL/yNeyAHIxnD7CwPD32HdS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11625
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Dec 2023 06:08:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14191

Hi all,

CIP kernel team has released Linux kernel v5.10.205-cip42 and v6.1.67-cip12=
.
The linux-5.10.y-cip tree has been updated base version from v5.10.201 to v=
5.10.205,
and The linux-6.1.y-cip tree has been updated base version from v6.1.66 to =
v6.1.67.
The linux-5.10.y-cip tree adds graphics, multimedia and clock drivier patch=
es for Renesas
ARM64 SoCs.

You can get this release via the git tree at:

  v5.10.205-cip42:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      3ce67a889168be63cffd93c9aa7cf26532711f7b
    Fixed CVEs:
      CVE-2023-46862: io_uring/fdinfo: lock SQ thread while retrieving thre=
ad cpu/pid
    added commits:
      CIP: Bump version suffix to -cip42 after merge from stable
      arm64: dts: renesas: rzg2lc-smarc-som: Add vdd core regulator
      arm64: dts: renesas: rzg2l-smarc-som: Add vdd core regulator
      arm64: dts: renesas: r9a07g054: Fillup the GPU node
      arm64: dts: renesas: r9a07g044: Add Mali-G31 GPU node
      dt-bindings: gpu: mali-bifrost: Document RZ/V2L SoC
      dt-bindings: gpu: mali-bifrost: Document RZ/G2L support
      arm64: dts: renesas: Drop ADV7535 IRQ
      arm64: dts: renesas: rzg2lc-smarc: Link DSI with ADV7535
      arm64: dts: renesas: rzg2l-smarc: Link DSI with ADV7535
      arm64: dts: renesas: r9a07g054: Add DSI node
      arm64: dts: renesas: r9a07g044: Add DSI node
      arm64: defconfig: Enable Renesas RZ/G2L MIPI DSI driver
      drm: rcar-du: rzg2l_mipi_dsi: Reorder bridge attach
      drm: rcar-du: rzg2l_mipi_dsi: Enhance device lanes check
      drm: rcar-du: Fix Kconfig dependency between DRM and RZG2L_MIPI_DSI
      drm: rcar-du: Add RZ/G2L DSI driver
      dt-bindings: display: bridge: renesas,rzg2l-mipi-dsi: Document RZ/V2L=
 support
      dt-bindings: display: bridge: Document RZ/G2L MIPI DSI TX bindings
      drm: of: Mark empty drm_of_get_data_lanes_count and drm_of_get_data_l=
anes_ep static
      drm: of: Add drm_of_get_data_lanes_count and drm_of_get_data_lanes_ep
      drm/bridge: Move devm_drm_of_get_bridge to bridge/panel.c
      drm/bridge: Add stubs for devm_drm_of_get_bridge when OF is disabled
      drm/bridge: Add a function to abstract away panels
      arm64: dts: renesas: r9a07g054: Add vspd node
      arm64: dts: renesas: r9a07g054: Add fcpvd node
      arm64: dts: renesas: r9a07g044: Add vspd node
      arm64: dts: renesas: r9a07g044: Add fcpvd node
      media: renesas: vsp1: Add support for RZ/G2L VSPD
      media: dt-bindings: media: renesas,vsp1: Document RZ/V2L VSPD binding=
s
      media: dt-bindings: media: renesas,vsp1: Document RZ/G2L VSPD binding=
s
      media: renesas: vsp1: Add VSP1_HAS_NON_ZERO_LBA feature bit
      media: vsp1: Use BIT macro for feature identification
      media: renesas: vsp1: Add support for VSP software version
      media: renesas: vsp1: Add support to deassert/assert reset line
      media: vsp1: mask interrupts before enabling
      media: vsp1: Use platform_get_irq() to get the interrupt
      media: vsp1: Simplify DRM UIF handling
      media: vsp1: Fix WPF macro names
      media: vsp1: Make use of the helper function
devm_platform_ioremap_resource()
      media: vsp1: use pm_runtime_resume_and_get()
      device property: Add const qualifier to device_get_match_data() param=
eter
      clk: renesas: rzg2l: Fix CPG_SIPLL5_CLK1 register write
      clk: renesas: r9a07g044: Add POEG clock and reset entries
      clk: renesas: r9a07g044: Add GPT clock and reset entry
      clk: renesas: r9a07g044: Add DSI clock and reset entries
      clk: renesas: r9a07g044: Add LCDC clock and reset entries
      clk: renesas: r9a07g044: Add M4 Clock support
      clk: renesas: r9a07g044: Add M3 Clock support
      clk: renesas: r9a07g044: Add {M2, M2_DIV2} Clocks support
      clk: renesas: r9a07g044: Add M1 clock support
      clk: renesas: rzg2l: Add DSI divider clk support
      clk: renesas: rzg2l: Add PLL5_4 clk mux support
      clk: renesas: rzg2l: Add FOUTPOSTDIV clk support
      clk: renesas: r9a07g043: Drop WDT2 clock and reset entry
      clk: renesas: r9a07g044: Drop WDT2 clock and reset entry
      arm64: dts: renesas: rzg2ul-smarc: Move spi1 pinmux to carrier board =
DTSI
      arm64: dts: renesas: rzg2l: Drop WDT2 nodes
      arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
      arm64: dts: renesas: rz-smarc: Use versa3 clk for audio mclk
      clk: vc3: Make vc3_clk_mux enum values based on vc3_clk enum
      clk: vc3: Fix output clock mapping
      clk: vc3: Fix 64 by 64 division
      clk: Add support for versa3 clock driver
      clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw(=
)
      clk: fixed: Remove Allwinner A10 special-case logic
      clk: fixed-factor: Introduce devm_clk_hw_register_fixed_factor_index(=
)
      clk: fixed: add devm helper for clk_hw_register_fixed_factor()
      dt-bindings: clock: versaclock3: Add description for #clock-cells pro=
perty
      dt-bindings: clock: Add Renesas versa3 clock generator bindings

  v6.1.67-cip12:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      33a81955d654c80f6f9626f5bd3def02b8e85b3a
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip12 after merge from stable
      ASoC: dt-bindings: renesas,rz-ssi: Update interrupts and interrupt-na=
mes properties

Best regards,
   Nobuhiro


