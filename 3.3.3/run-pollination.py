""""
This is a saved model run from natcap.invest.pollination.pollination.
Generated: Mon 22 Jan 2018 18:09:45 
InVEST version: 3.3.0.post22+n11fd1e0302ef
"""

import natcap.invest.pollination.pollination


args = {
        u'ag_classes': '67 68 71 72 73 74 75 76 78 79 80 81 82 83 84 85 88 90 91 92',
        u'do_valuation': False,
        u'guilds_uri': u'/data/Pollination/Input/Guild.csv',
        u'half_saturation': 0.125,
        u'landuse_attributes_uri': u'/data/Pollination/Input/LU.csv',
        u'landuse_cur_uri': u'/data/Base_Data/Terrestrial/lulc_samp_cur/hdr.adf',
        u'results_suffix': u'',
        u'wild_pollination_proportion': 1.0,
        u'workspace_dir': u'/workspace/pollination',
}

if __name__ == '__main__':
    natcap.invest.pollination.pollination.execute(args)

