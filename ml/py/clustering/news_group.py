import sklearn.datasets

mlcomp_dir = r'D:\andersc\data\ml'


def load_data(set_, categories):
    """
    :param set_: can only be one of 'raw', 'train', 'test'
    :param categories:
    """
    return sklearn.datasets.load_mlcomp('20news-18828', set_, mlcomp_root=mlcomp_dir, categories=categories)


def raw(categories=None):
    return load_data('raw', categories)


def train(categories=None):
    return load_data('train', categories)


def test(categories=None):
    return load_data('test', categories)


if __name__ == '__main__':
    # data = raw()
    # assert len(data.filenames) == 18828
    # print(data.target_names)
    #
    # data = train()
    # assert len(data.filenames) == 13180
    # # print(data.target_names)

    groups = ['comp.graphics', 'comp.os.ms-windows.misc',
              'comp.sys.ibm.pc.hardware', 'comp.sys.ma c.hardware',
              'comp.windows.x', 'sci.space']
    data = train(groups)
    assert len(data.filenames) == 3414
    print(data.target_names)

    # data = test()
    # assert len(data.filenames) == 5648
    # # print(data.target_names)

