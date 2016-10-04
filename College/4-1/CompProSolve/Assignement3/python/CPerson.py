from __future__ import print_function


class CPerson:
    __m_age = None
    __m_name = None
    

    def __init__(self, name="", age=0):
        self.__m_name = name
        self.__m_age = age

    def get_age(self):
        #retuerns
        return self.__m_age

    def get_name(self):
        return self.__m_name

    def set_age(self, age):
        self.__m_age = age

    def set_name(self, name):
        self.__m_name = name

    def to_string(self):
        result = ""
        result += "Name: " + " " + str(self.__m_name) + '\n'
        result += "Age: " + str(self.__m_age)
        return result

    def save_object(self, file_writer):
        file_writer.write("{0} : {1}\n".format(str(self.__m_name), str(self.__m_age)))

    def load_object(self, data):
            data_list = data.split(":")
            self.set_name(data_list[0])
            self.__m_age = data_list[1]


if __name__ == '__main__':
    pass
